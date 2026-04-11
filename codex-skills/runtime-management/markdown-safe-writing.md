---
name: markdown-safe-writing
description: Markdown이나 일반 문서를 수정할 때 Windows PowerShell 경유 한글 입력 손상과 UTF-8 인코딩 문제를 방지하기 위한 문서 작성 규칙이다.
---

# Markdown Safe Writing Skill

## 목적

- Markdown, txt, 설정 문서를 수정할 때 한글이 `?`로 치환되거나 인코딩이 깨지는 문제를 막는다.
- 저장 인코딩뿐 아니라 **입력 경로**, **검증 절차**, **리뷰 범위**까지 강제한다.

## 핵심 결론

- UTF-8로 저장하는 것만으로는 부족하다.
- Windows PowerShell에서 한글 본문을 heredoc, 파이프, 표준입력으로 직접 넘기면 저장 전에 이미 손상될 수 있다.
- 따라서 문서 수정은 **입력 경로가 안전한 방식**을 먼저 선택해야 한다.

## 우선순위

1. **`apply_patch`로 직접 수정**
2. Python `Path(...).write_text(..., encoding='utf-8')` 사용
   - 단, Python 코드 안의 긴 한글 본문은 PowerShell heredoc로 직접 전달하지 않는다.
   - 필요하면 Base64, 유니코드 이스케이프, 기존 파일 복사 후 부분 치환 같은 ASCII-safe 방식으로 전달한다.
3. PowerShell `Set-Content -Encoding utf8`, `Out-File -Encoding utf8`
   - ASCII 위주이거나 이미 안전한 변수/파일을 대상으로 할 때만 사용한다.

## 필수 규칙

1. `.md`, `.txt`, `.json`, `.yaml`, `.yml`, `.ini`, `.cfg` 등 텍스트 문서는 항상 UTF-8 기준으로 다룬다.
2. Windows PowerShell에서 한글 본문을 다음 방식으로 직접 전달하지 않는다.
   - here-string (`@' ... '@`)
   - 파이프 입력
   - 표준입력 리다이렉션
3. Markdown 문서 수정은 가능하면 `apply_patch`를 1순위로 사용한다.
4. 문서 전체를 새로 쓸 때도, 긴 한글 본문을 PowerShell 문자열로 직접 만들지 않는다.
5. 문서가 이미 깨졌다면 단순 덮어쓰기로 끝내지 말고, **정상 원문을 다시 주입**해서 복구한다.
6. `Get-Content` 출력이 깨져 보여도 파일 자체가 정상일 수 있으므로, **콘솔 표시 문제와 파일 손상 문제를 분리**해서 판단한다.
7. 반대로 `read_text(encoding='utf-8')`가 성공해도 파일이 정상이라고 단정하지 않는다. 한글이 `?`로 치환된 경우도 있기 때문이다.
8. Claude 교차 리뷰를 요청할 때는 수치·논리 검토 외에 **문자 깨짐/인코딩 확인**을 명시한다.

## 금지 사항

1. 한글 Markdown 본문을 PowerShell heredoc로 만들어 `python -`에 직접 전달하지 않는다.
2. 한글 문서를 작성한 뒤 ASCII 문자열만 확인하고 종료하지 않는다.
3. `?`가 많이 보이는 문서를 “콘솔 문제겠지”라고 추정만 하고 종료하지 않는다.
4. 문서 손상 사고가 발생했는데 관련 규칙 문서와 history 기록을 남기지 않고 끝내지 않는다.

## 권장 작업 절차

### 1. 수정 방식 선택

- 부분 수정: `apply_patch`
- 전체 재작성: `apply_patch` 또는 ASCII-safe Python 작성
- 외부 스크립트 사용: UTF-8 명시 + 한글 payload는 ASCII-safe 전달

### 2. 저장 직후 필수 검증

아래를 모두 확인한다.

1. `read_bytes()`로 바이트 확인
2. `read_text(encoding='utf-8')`로 UTF-8 읽기 확인
3. 비정상적인 `?` 반복 여부 확인
4. 대표 한글 문장 2개 이상이 실제 문자열로 존재하는지 확인

### 3. 교차 리뷰가 필요한 경우

리뷰 요청에 아래를 포함한다.

- 수치/논리 정합성 확인
- 인코딩 손상 여부 확인
- 한글 문장 보존 여부 확인

## 검증 명령 예시

```powershell
python -c "from pathlib import Path; p = Path(r'D:\work\sample.md'); raw = p.read_bytes(); text = p.read_text(encoding='utf-8'); print(raw[:80]); print(text[:120].encode('unicode_escape').decode()); print(text.count('?')); print('실험 개요' in text); print('핵심 결과' in text)"
```

## 사고 발생 시 처리

1. 손상된 파일을 그대로 부분 덮어쓰지 말고, 정상 본문 기준으로 다시 복구한다.
2. 원인을 아래 세 가지로 분리해 기록한다.
   - 저장 인코딩 문제
   - 입력 경로 문제
   - 검증 절차 누락
3. 관련 규칙 문서를 수정했으면 `history/skill_YYYYMMDD.md`를 즉시 만든다.

## 보고 시 포함할 항목

- 수정 파일 목록
- 사용한 저장 방식
- UTF-8 검증 결과
- 한글 보존 검증 결과
- 교차 리뷰 여부와 리뷰 범위
