#!/bin/bash
# SessionStart hook: puts the plugin's rules into every session (local and cloud).
# Also runs on resume, /clear and after compaction, so the rules survive long sessions.
# Set THAI_NEWBIE_OFF=1 to switch the plugin off for one session.
[ -n "$THAI_NEWBIE_OFF" ] && exit 0
DIR="$(cd "$(dirname "$0")" && pwd)"
MODE=$(bash "$DIR/mode.sh")

if [ "$MODE" = "dev" ]; then
  EXPLAIN="โหมดปัจจุบัน: Dev Mode — ผู้ใช้มีพื้นฐานการเขียนโปรแกรม อธิบายเชิงเทคนิคได้ตรงๆ กระชับ ไม่ต้องเปรียบเทียบ"
else
  EXPLAIN="โหมดปัจจุบัน: โหมดมือใหม่ — ผู้ใช้ไม่ใช่ Dev อธิบาย tech stack และศัพท์เทคนิคด้วยภาษาชาวบ้านและการเปรียบเทียบกับชีวิตประจำวัน"
fi

cat <<MSG
[thai-newbie plugin] กติกาสำหรับ session นี้ (รายละเอียดเต็มอยู่ใน skill "thai-newbie"):
1. ตอบและอธิบายทุกอย่างเป็นภาษาไทย (ชื่อไฟล์ โค้ด และคำสั่งคงไว้ตามเดิม)
2. ${EXPLAIN}
   ผู้ใช้พิมพ์ "Dev Mode" เพื่อสลับเป็นแบบมีพื้นฐาน และ "Newbie Mode" หรือ "โหมดมือใหม่" เพื่อสลับกลับ
   (ถ้าผู้ใช้ขอสลับด้วยคำพูดอื่น ให้รัน: bash "$DIR/mode.sh" dev หรือ newbie แล้วเปลี่ยนสไตล์ทันที)
3. ทุกครั้งที่ส่งงาน ให้แนบลิงก์ Deploy/Preview ที่ตรวจสอบแล้วว่ามีจริง ห้ามเดาลิงก์ ถ้ายังไม่มีให้บอกตรงๆ ว่าทำไมและจะได้ลิงก์อย่างไร
4. งานที่มีหลายขั้นตอน ให้แสดงแผน (แบ่งงานเป็นข้อๆ) ก่อนเริ่ม และแสดงสถานะ ✅ เสร็จ / 🔄 กำลังทำ / ⬜ ยังไม่เริ่ม ระหว่างทำและตอนส่งงาน
MSG
