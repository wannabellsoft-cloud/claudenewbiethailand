# Claude Newbie Thailand 🇹🇭

Plugin **thai-newbie** สำหรับ [Claude Code](https://claude.com/claude-code) ที่ทำให้ Claude เป็นผู้ช่วยที่เหมาะกับมือใหม่ชาวไทย
ใช้ได้ทั้งในเครื่อง (Windows / Mac / Linux) และ cloud session บน claude.ai หรือแอปมือถือ

## ได้อะไรบ้าง

| | ความสามารถ | ตัวอย่าง |
| --- | --- | --- |
| 🇹🇭 | **ตอบเป็นภาษาไทย** | คำตอบ คำอธิบาย และการอธิบาย error เป็นไทยทั้งหมด ส่วนโค้ดและคำสั่งคงไว้ตามเดิม |
| 🧑‍🎓 | **อธิบายแบบคนไม่ใช่ Dev เข้าใจ** | "Database = ตู้เก็บเอกสาร", "Deploy = เอาร้านขึ้นห้างให้คนอื่นเข้ามาใช้ได้" พร้อมตารางสรุป tech stack ของโปรเจกต์ |
| 👩‍💻 | **Dev Mode** | พิมพ์ `Dev Mode` เพื่อให้อธิบายเชิงเทคนิคแบบคนมีพื้นฐาน พิมพ์ `Newbie Mode` เพื่อกลับ |
| 🔗 | **แนบลิงก์ Deploy ทุกครั้งที่ส่งงาน** | เปิดดูผลงานได้ทันที (ใช้เฉพาะลิงก์ที่มีจริง ถ้ายังไม่มีจะบอกวิธีได้ลิงก์) |
| 📋 | **แสดงแผนและความคืบหน้า** | แบ่งงานเป็นข้อๆ ก่อนเริ่ม และอัปเดต ✅ เสร็จ / 🔄 กำลังทำ / ⬜ ยังไม่เริ่ม |

## วิธีติดตั้ง (2 ขั้นตอน)

เปิด Claude Code แล้วพิมพ์ทีละบรรทัด:

```
/plugin marketplace add wannabellsoft-cloud/claudenewbiethailand
```

```
/plugin install thai-newbie@claudenewbiethailand
```

จากนั้น **ปิดแล้วเปิด Claude Code ใหม่** (หรือเริ่ม session ใหม่) — ใช้ได้ทันที

> **plugin คืออะไร?** ชุดเสริมที่เพิ่มความสามารถให้ Claude Code ติดตั้งครั้งเดียว ใช้ได้ทุกโปรเจกต์

## สลับโหมดการอธิบาย

| พิมพ์ | ผลลัพธ์ |
| --- | --- |
| `Dev Mode` (หรือ `/thai-newbie:dev-mode`) | อธิบายเชิงเทคนิค กระชับ แบบคนมีพื้นฐาน |
| `Newbie Mode` หรือ `โหมดมือใหม่` (หรือ `/thai-newbie:newbie-mode`) | กลับมาอธิบายแบบคนไม่ใช่ Dev (ค่าเริ่มต้น) |

Claude จำโหมดที่เลือกไว้ ครั้งหน้าเปิดมาก็ยังเป็นโหมดเดิม

**อยากให้เริ่มที่ Dev Mode เลย?** เพิ่มใน `.claude/settings.json` (ของโปรเจกต์ หรือของเครื่องที่ `~/.claude/settings.json`):

```json
{
  "env": { "THAI_NEWBIE_DEFAULT_MODE": "dev" }
}
```

ค่านี้ใช้จนกว่าผู้ใช้จะพิมพ์สลับโหมดเอง เหมาะกับ cloud session ที่จำโหมดข้าม session ไม่ได้

## ใช้ใน cloud session (claude.ai / แอปมือถือ)

Cloud session เริ่มจากเครื่องใหม่ทุกครั้ง จึงต้องให้โปรเจกต์ของคุณเรียกใช้ plugin นี้เอง
สร้างไฟล์ `.claude/settings.json` ในโปรเจกต์ (หรือเพิ่มเข้าไปในไฟล์เดิม) แล้ว commit + push:

```json
{
  "extraKnownMarketplaces": {
    "claudenewbiethailand": {
      "source": { "source": "github", "repo": "wannabellsoft-cloud/claudenewbiethailand" }
    }
  },
  "enabledPlugins": {
    "thai-newbie@claudenewbiethailand": true
  }
}
```

> ใน cloud session โหมดที่เลือก (Dev / มือใหม่) จะกลับเป็นค่าเริ่มต้นทุกครั้งที่เริ่ม session ใหม่
> เพราะเครื่องถูกสร้างใหม่ทุกครั้ง — ถ้าอยากเริ่มที่ Dev Mode ให้เพิ่ม `"env": { "THAI_NEWBIE_DEFAULT_MODE": "dev" }`
> ในไฟล์เดียวกันนี้

## ปิดชั่วคราว / ถอนการติดตั้ง

- ปิดชั่วคราว: `/plugin disable thai-newbie@claudenewbiethailand` (เปิดกลับด้วย `enable`)
- ถอนการติดตั้ง: `/plugin uninstall thai-newbie@claudenewbiethailand`
- ปิดเฉพาะครั้งนี้: ตั้งตัวแปร `THAI_NEWBIE_OFF=1` ก่อนเปิด Claude Code

## ทำงานอย่างไร

| ไฟล์ | หน้าที่ |
| --- | --- |
| `plugins/thai-newbie/scripts/session-start.sh` | รันทุกครั้งที่เริ่ม session บอกกติกาทั้ง 4 ข้อและโหมดปัจจุบันให้ Claude |
| `plugins/thai-newbie/scripts/prompt-mode.sh` | จับข้อความ `Dev Mode` / `Newbie Mode` แล้วสลับโหมดให้ |
| `plugins/thai-newbie/scripts/mode.sh` | อ่านและบันทึกโหมด (เก็บใน `~/.claude/thai-newbie-mode`) |
| `plugins/thai-newbie/commands/` | คำสั่ง `/thai-newbie:dev-mode` และ `/thai-newbie:newbie-mode` |
| `plugins/thai-newbie/skills/thai-newbie/SKILL.md` | กติกาละเอียดทั้งหมด |

อยากปรับสไตล์? Fork repo นี้แล้วแก้ `SKILL.md` ได้เลย

## License

MIT
