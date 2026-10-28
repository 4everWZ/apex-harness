"""Prepare isolated inputs; does not evaluate document semantics."""
from pathlib import Path
import json
import shutil
import sys

HERE = Path(__file__).resolve().parent
REPO = HERE.parents[2]
action, run_name, case_name, *extra = sys.argv[1:]
if not run_name or run_name in ('.', '..') or '/' in run_name or '\\' in run_name:
    raise SystemExit('RUN must be one directory name')
if case_name not in ('software', 'algorithm', 'small', 'algorithm-build', 'internal-algorithm'):
    raise SystemExit('Unknown case')
run = REPO / 'tmp' / run_name
project = run / case_name
source_case = 'algorithm' if case_name == 'algorithm-build' else case_name
if action == 'start':
    if project.exists():
        raise SystemExit('Refusing to overwrite an existing project')
    rules = run / 'rules'
    if not rules.exists():
        rules.mkdir(parents=True)
        for skill in ('apex-harness', 'managing-project-docs'):
            shutil.copytree(REPO / 'skills' / skill, rules / skill)
    shutil.copytree(HERE / 'cases' / source_case / 'initial', project / 'tmp')
elif action == 'advance':
    later = HERE / 'cases' / case_name / 'later'
    if not project.is_dir() or not later.is_dir():
        raise SystemExit('Project or later input does not exist')
    files = [p for p in later.rglob('*') if p.is_file()]
    if any((project / 'tmp' / p.relative_to(later)).exists() for p in files):
        raise SystemExit('Refusing to overwrite supplied materials')
    for path in files:
        target = project / 'tmp' / path.relative_to(later)
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(path, target)
elif action == 'snapshot':
    if extra not in (['initial'], ['updated']) or not project.is_dir():
        raise SystemExit('Use snapshot RUN CASE initial|updated on an existing project')
    stage = extra[0]
    destination = HERE / 'results' / run_name / case_name / stage
    if destination.exists():
        raise SystemExit('Refusing to overwrite a snapshot')
    inputs_unchanged = True
    for phase in ('initial', 'later') if stage == 'updated' else ('initial',):
        source = HERE / 'cases' / source_case / phase
        for path in source.rglob('*'):
            if path.is_file():
                actual = project / 'tmp' / path.relative_to(source)
                inputs_unchanged &= actual.is_file() and actual.read_bytes() == path.read_bytes()
    documents = {}
    other_files = []
    for path in sorted(project.rglob('*')):
        if not path.is_file():
            continue
        relative = path.relative_to(project)
        if relative.parts[0] == 'tmp' or '__pycache__' in relative.parts:
            continue
        if path.suffix == '.md':
            target = destination / (relative.as_posix() + '.txt')
            target.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(path, target)
            documents[relative.as_posix()] = path.read_text(encoding='utf-8')
        else:
            other_files.append(relative.as_posix())
    print(json.dumps(dict(case=case_name, stage=stage, inputs_unchanged=inputs_unchanged,
                         documents=documents, other_files=other_files), ensure_ascii=False))
    raise SystemExit(0)
else:
    raise SystemExit('Use start, advance, or snapshot')
print(project)
