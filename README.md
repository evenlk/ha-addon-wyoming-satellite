
# Wyoming Satellite — Home Assistant Add-on

Run the upstream [`rhasspy/wyoming-satellite`](https://github.com/rhasspy/wyoming-satellite) engine inside **Home Assistant OS** with HA Audio (PulseAudio) mic capture.  
Works on `aarch64`, `amd64`, and `armv7`. Default port: **10700/tcp**.

[![Open this repository in Home Assistant](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/evenlk/ha-addon-wyoming-satellite)  
[![Buy Me A Coffee](https://img.shields.io/badge/%E2%98%95%EF%B8%8F-Buy%20me%20a%20coffee-yellow?logo=buymeacoffee)](https://buymeacoffee.com/evenlk)

---

## 📋 Prerequisites

1. **Wyoming Protocol integration** in Home Assistant  
   - Go to **Settings → Devices & Services → Add Integration → Wyoming**  
   - Docs: https://www.home-assistant.io/integrations/wyoming/

2. **A working Voice Assist setup** (TTS + STT). Piper + OpenAI Whisper or similar is fine.  
   - Guide: [Voice Assist in Home Assistant](https://www.home-assistant.io/voice_control/)

3. **OpenWakeWord service** for wake word detection (recommended)  
   - HA Add-on (one-click): [OpenWakeWord](https://my.home-assistant.io/redirect/supervisor_addon/?addon=core_openwakeword)  
   - Upstream project: https://github.com/dscripka/openWakeWord

4. (Optional) A speaker output for feedback/announcements.

---

## 🎤 Microphone discovery

This add-on will work with **any audio input device that HA OS can detect** — USB mics, built-in mics, sound cards, even webcam/HDMI mics.
It will automatically discover your devices (drop down menu in the configuration page). If you have issues, you can manually set them.

To list available devices:

1. Install the **Advanced SSH & Web Terminal** add-on (Community add-ons).  
2. Run the command:
   ```bash
   ha audio info
   ```
3. You’ll see a list of **sources** (microphones) and **sinks** (speakers).  
   Example:
   ```
   source: alsa_input.usb-0d8c_USB_Sound_Device-00.analog-stereo
   sink: alsa_output.pci-0000_00_1b.0.analog-stereo
   ```

Use these names in your config options (see below).

---

## 🚀 Install

**Option A: Add the repo via one click**  
[![Open this repository in Home Assistant](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)]([https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/evenlk/ha-addon-wyoming-satellite])

**Option B: Manually**  
1. In Home Assistant: **Settings → Add-ons → Add-on Store → ⋮ → Repositories → Add**  
2. Paste this URL: `https://github.com/evenlk/ha-addon-wyoming-satellite`  
3. Install **Wyoming Satellite** and start the add-on.

---

## ⚙️ Configuration (Add-on options)

```yaml
uri: "tcp://0.0.0.0:10700"                     
mic_command: 'parec --device="alsa_input.usb-XXXX" --latency-msec=50 --format=s16le --rate=16000 --channels=1'
snd_command: 'paplay --device="alsa_output.usb-YYYY" -'
wake_uri: "tcp://core-openwakeword:10400"
wake_word_name: "hey_jarvis"
debug: true
```

Replace `alsa_input...` / `alsa_output...` with the names from `ha audio info`. You only need to do this if auto-discovery doesn't work. (check devices discovered in the configuration page)

### 🔊 Add a speaker (audio out)
If you want sound output from the satellite, set `snd_command` to your audio sink.  
Example:
```yaml
snd_command: "paplay --device=alsa_output.pci-0000_00_1b.0.analog-stereo -"
```

---

## 🖥️ Home Assistant integration

Add the **Wyoming** integration (auto-discovered, or manually via **Settings → Devices & Services → Add Integration → Wyoming**) and set the server to:

```
tcp://<HA-IP>:10700
```

---

## 🔧 Troubleshooting

- **No mic input?** → Run `ha audio info` and make sure `mic_command` matches the correct source.  
- **Wake word not triggering?** → Verify `wake_uri` resolves (default `core-openwakeword:10400`); try another `wake_word_name`.  
- **No sound?** → Point `snd_command` to a valid sink and test with `paplay /usr/share/sounds/alsa/Front_Center.wav`.  
- **Need more logs?** → Set `debug: true`.

---

## 📦 Versions

- Add-on: **0.1.5**  
- Upstream: [`rhasspy/wyoming-satellite`](https://github.com/rhasspy/wyoming-satellite)

---

## 🙏 Credits

- Engine: [`rhasspy/wyoming-satellite`](https://github.com/rhasspy/wyoming-satellite)  
- Add-on packaging for HA OS: **evenlk**

---

## ☕ Support

If this add-on helped you:  
[![Buy Me A Coffee](https://img.shields.io/badge/%E2%98%95%EF%B8%8F-Buy%20me%20a%20coffee-yellow?logo=buymeacoffee)](https://buymeacoffee.com/evenlk)
