#!/bin/bash
# UserPromptSubmit hook: when the whole message is a mode switch ("Dev Mode", "Newbie Mode", "โหมดมือใหม่", ...),
# save the new mode and tell Claude to switch style now. Longer messages that merely mention "dev mode" are ignored.
[ -n "$THAI_NEWBIE_OFF" ] && exit 0
DIR="$(cd "$(dirname "$0")" && pwd)"
INPUT=$(cat)
END='[[:space:].!]*"'
START='"prompt"[[:space:]]*:[[:space:]]*"[[:space:]]*/?'

if printf '%s' "$INPUT" | grep -Eiq "${START}((ปิด|off)[[:space:]]*dev[[:space:]]*mode|dev[[:space:]]*mode[[:space:]]*off|newbie[[:space:]]*mode|โหมด[[:space:]]*มือใหม่|(thai-newbie:)?newbie-mode)${END}"; then
  bash "$DIR/mode.sh" newbie >/dev/null
  echo "[thai-newbie plugin] ผู้ใช้สลับเป็นโหมดมือใหม่แล้ว (บันทึกไว้แล้ว) — ยืนยันสั้นๆ เป็นภาษาไทย แล้วจากนี้อธิบาย tech stack และศัพท์เทคนิคด้วยภาษาชาวบ้านและการเปรียบเทียบ"
elif printf '%s' "$INPUT" | grep -Eiq "${START}((เปิด|on)?[[:space:]]*dev[[:space:]]*mode([[:space:]]*on)?|โหมด[[:space:]]*dev|(thai-newbie:)?dev-mode)${END}"; then
  bash "$DIR/mode.sh" dev >/dev/null
  echo "[thai-newbie plugin] ผู้ใช้สลับเป็น Dev Mode แล้ว (บันทึกไว้แล้ว) — ยืนยันสั้นๆ เป็นภาษาไทย แล้วจากนี้อธิบายเชิงเทคนิคได้ตรงๆ กระชับ ไม่ต้องเปรียบเทียบ (ยังตอบเป็นภาษาไทย)"
fi
exit 0
