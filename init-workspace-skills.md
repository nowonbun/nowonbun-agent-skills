---
name: init-workspace-skills
description: 워크스페이스나 프로젝트에 공통 지침과 스킬 시트를 초기화하거나 업데이트할 때 사용한다. global_instructions.md를 프로젝트 루트로 복사하고, 각 스킬 시트는 ~/.codex/skills/<스킬파일명>/SKILL.md로 복사하며, 복사된 위치에 맞게 문서 내부 경로와 .codex/config.toml의 경로를 수정한다.
---

# Init Workspace Skills Skill

## 목적
중앙 스킬 저장소의 `global_instructions.md`와 각 스킬 시트를 워크스페이스 또는 프로젝트 기준 위치로 초기화하고, 이후 업데이트 시 같은 규칙으로 덮어쓰기하는 절차를 고정한다.

## 규칙
1. 소스 저장소는 기본적으로 `D:/work/nownobun-agent-skills`로 본다.
2. `D:/work/nownobun-agent-skills/global_instructions.md`는 대상 프로젝트의 루트에 `global_instructions.md`로 복사한다.
3. 소스 저장소의 각 스킬 시트(`*.md`)는 `~/.codex/skills/<파일명에서 .md 제거>/SKILL.md`로 복사한다.
4. 스킬 디렉터리명은 원본 파일명에서 확장자 `.md`를 제거한 값과 일치해야 한다. 예: `ai-agent.md` -> `~/.codex/skills/ai-agent/SKILL.md`
5. 복사 대상 스킬 시트에는 `global_instructions.md`는 포함하지 않는다.
6. 복사 후에는 각 파일 내부에 남아 있는 원본 저장소 경로를 복사된 위치 기준 경로로 수정한다.
7. 경로 수정 대상에는 원본 저장소 경로의 슬래시 표기 변형(`/` 및 `\`)이 모두 포함되어야 한다. 최소한 아래를 치환 대상으로 본다.
   - `D:/work/nownobun-agent-skills/global_instructions.md`
   - `D:/work/nownobun-agent-skills/<skill>.md`
   - `D:\work\nownobun-agent-skills\global_instructions.md`
   - `D:\work\nownobun-agent-skills\<skill>.md`
8. 스킬 시트 안에서 다른 스킬 시트를 참조하는 경로는 가능한 한 복사된 경로 기준으로 바꾼다. 즉 `~/.codex/skills/<대상스킬>/SKILL.md` 또는 해당 위치를 가리키는 절대경로로 맞춘다.
9. 설정 파일 반영 대상은 프로젝트 하위 `.codex/config.toml`가 아니라 사용자 홈 경로의 `~/.codex/config.toml`로 본다. Windows 기준 기본 경로는 `C:\Users\<사용자명>\.codex\config.toml`이다.
10. `~/.codex/config.toml`이 존재하면 아래를 함께 수정한다.
   - `model_instructions_file`은 프로젝트 루트에 복사된 `global_instructions.md` 경로로 맞춘다.
   - 스킬 경로 설정은 `~/.codex/skills/<스킬명>/SKILL.md` 기준으로 맞춘다.
11. 사용자가 "초기화"를 말하면 대상 파일이 없어도 생성한다.
12. 사용자가 "업데이트"를 말하면 기존 파일을 같은 규칙으로 덮어쓴다.
13. 업데이트 시 기존에 복사되어 있는 파일 내용은 보존하지 않는다. 원본 시트를 기준으로 다시 복사하고 경로를 다시 치환한다.
14. 복사와 경로 수정 후에는 최소한 아래를 검증한다.
   - 프로젝트 루트의 `global_instructions.md` 존재 여부
   - `~/.codex/skills/<스킬명>/SKILL.md` 존재 여부
   - 문서 내부에 원본 경로가 남아 있는지 여부
   - `~/.codex/config.toml` 경로 반영 여부

## 절차
1. 대상 프로젝트 루트 경로를 확인한다.
2. `global_instructions.md`를 프로젝트 루트로 복사한다.
3. 복사할 스킬 시트 목록을 정한다.
4. 각 스킬 시트마다 `~/.codex/skills/<스킬명>/` 디렉터리를 만든다.
5. 각 스킬 시트를 해당 디렉터리의 `SKILL.md`로 복사한다.
6. 복사된 `global_instructions.md`와 각 `SKILL.md` 안의 경로를 새 위치 기준으로 수정한다.
7. `~/.codex/config.toml`이 있으면 `model_instructions_file`과 스킬 경로를 수정한다.
8. 사용자가 업데이트를 요청한 경우에도 위 절차를 동일하게 반복하고 기존 파일은 덮어쓴다.

## 산출물 형식
- 프로젝트 루트: `global_instructions.md`
- 사용자 홈 스킬 경로: `~/.codex/skills/<스킬명>/SKILL.md`
- 설정 반영 대상: `~/.codex/config.toml`

## 예시 매핑
- `D:/work/nownobun-agent-skills/ai-agent.md`
  -> `~/.codex/skills/ai-agent/SKILL.md`
- `D:/work/nownobun-agent-skills/coding-assistant.md`
  -> `~/.codex/skills/coding-assistant/SKILL.md`
