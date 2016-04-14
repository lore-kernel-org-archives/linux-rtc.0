Return-Path: <rtc-linux+bncBDVNH3HM2UDBBVMKXW4AKGQE7FMRBQY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-ob0-x22d.google.com (mail-ob0-x22d.google.com. [2607:f8b0:4003:c01::22d])
        by gmr-mx.google.com with ESMTPS id uh9si1479166igb.1.2016.04.14.00.23.01
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Apr 2016 00:23:01 -0700 (PDT)
Received: by mail-ob0-x22d.google.com with SMTP id bg3so44625570obb.1
        for <rtc-linux@googlegroups.com>; Thu, 14 Apr 2016 00:23:01 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 14 Apr 2016 11:23:00 +0400
Message-ID: <CABrG=Zw1g7a6YQnMEt6tJ5SeERM8OYcQ1=qvCegJy1G+n=WOcQ@mail.gmail.com>
Subject: [rtc-linux] RTC DS3231 returns wrong temperature value.
From: Michael Tatarinov <kukabu@gmail.com>
To: akinobu.mita@gmail.com
Cc: rtc-linux@googlegroups.com
Content-Type: multipart/mixed; boundary=089e012955ecaedcb205306cc3f7
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--089e012955ecaedcb205306cc3f7
Content-Type: text/plain; charset=UTF-8

Hello

I tried get temperature from RTC DS3231 (patch
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/rtc/rtc-ds1307.c?id=445c02076f1e60d2ee51503bf1288ef9f3bc8809)
but returned value wrong. Looks like the patch have a bug in type
conversion.
Sometime ago I wrote small program to gets temperature and it works
fine. I attaches the source code a modified version with a
demonstration of a bug.

$ cat /sys/devices/platform/soc/20804000.i2c/i2c-1/1-0068/hwmon/hwmon1/temp1_input
-29036
$ ./ds3231 -d /dev/i2c-1 -a 0x68 -m t -f
int     36500
int->int16_t    -29036

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--089e012955ecaedcb205306cc3f7
Content-Type: text/x-csrc; charset=US-ASCII; name="ds3231.c"
Content-Disposition: attachment; filename="ds3231.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: file0

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHN0ZGludC5o
PgojaW5jbHVkZSA8c3RkYm9vbC5oPgojaW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNsdWRlIDxlcnJu
by5oPgojaW5jbHVkZSA8dW5pc3RkLmg+CiNpbmNsdWRlIDxmY250bC5oPgojaW5jbHVkZSA8c3lz
L2lvY3RsLmg+CiNpbmNsdWRlIDxsaW51eC9pMmMuaD4KI2luY2x1ZGUgPGxpbnV4L2kyYy1kZXYu
aD4KCgojZGVmaW5lIERTMzIzMV9SRUdfVEVNUF9ISSAJMHgxMSAgCiNkZWZpbmUgRFMzMjMxX1JF
R19URU1QX0xPCTB4MTIgIAoKc3RhdGljIHZvaWQgdXNhZ2Uodm9pZCkgX19hdHRyaWJ1dGVfXyAo
KG5vcmV0dXJuKSk7CnN0YXRpYyB2b2lkIHVzYWdlKCkgewogICBmcHJpbnRmKHN0ZGVyciwgIlVz
YWdlOiBkczMyMzEgLWQgSTJDX0RFVklDRSAtYSBJMkNfQUREUkVTUyAtbSBNT0RFXG4iKTsKICAg
ZXhpdChFWElUX0ZBSUxVUkUpOwp9CgpzdGF0aWMgaW5saW5lIGludCBpMmNfc21idXNfcmVhZF9i
eXRlX2RhdGEoaW50IGkyY19jbGllbnQsIHVpbnQ4X3QgY29tbWFuZCkgewogICBzdHJ1Y3QgaTJj
X3NtYnVzX2lvY3RsX2RhdGEgYXJnczsKICAgdW5pb24gaTJjX3NtYnVzX2RhdGEgZGF0YTsKCiAg
IGFyZ3MucmVhZF93cml0ZSA9IEkyQ19TTUJVU19SRUFEOwogICBhcmdzLmNvbW1hbmQgPSBjb21t
YW5kOwogICBhcmdzLnNpemUgPSBJMkNfU01CVVNfQllURV9EQVRBOwogICBhcmdzLmRhdGEgPSAm
ZGF0YTsKCiAgIGlmIChpb2N0bChpMmNfY2xpZW50LCBJMkNfU01CVVMsICZhcmdzKSA9PSAtMSkK
ICAgICAgcmV0dXJuKC0xKTsKICAgZWxzZQogICAgICByZXR1cm4oMHgwMEZGICYgZGF0YS5ieXRl
KTsKfQoKc3RhdGljIGludCBkczMyMzFfZ2V0X3RlbXB0dXJlKGludCBpMmNfY2xpZW50LCBpbnQg
KnRlbXApIHsKICAgdWludDhfdCB0ZW1wX2hpLCB0ZW1wX2xvOwoKICAgdGVtcF9oaSA9IGkyY19z
bWJ1c19yZWFkX2J5dGVfZGF0YShpMmNfY2xpZW50LCBEUzMyMzFfUkVHX1RFTVBfSEkpOwogICBp
ZiAodGVtcF9oaSA9PSAtMSkKICAgICAgcmV0dXJuKC0xKTsKCiAgIHRlbXBfbG8gPSBpMmNfc21i
dXNfcmVhZF9ieXRlX2RhdGEoaTJjX2NsaWVudCwgRFMzMjMxX1JFR19URU1QX0xPKTsKICAgaWYg
KHRlbXBfbG8gPT0gLTEpCiAgICAgIHJldHVybigtMSk7CgogICAqdGVtcCA9ICh0ZW1wX2hpICYg
MHg3ZikgKiAxMDAwOwogICAqdGVtcCArPSAodGVtcF9sbyA+PiA2KSAqIDI1MDsKICAgaWYgKCAo
dGVtcF9oaSAmIDB4ODApID09IDB4ODAgKQogICAgICAqdGVtcCAqPSAtMTsKCiAgIHJldHVybigw
KTsKfQoKaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2LCBjaGFyICoqZW52cCkgewogICBp
bnQgb3B0LCBpMmNfZmQsIGkyY19hZGRyID0gLTE7CiAgIGludCB0ZW1wOwogICBjaGFyICppMmNf
ZGV2bmFtZSA9IE5VTEw7CiAgIGNoYXIgbW9kZSA9IC0xOwogICBib29sIGZvcmNlID0gZmFsc2Ug
OwoKICAgd2hpbGUgKChvcHQgPSBnZXRvcHQoYXJnYywgYXJndiwgImQ6YTptOmYiKSkgIT0gLTEp
IHsKICAgICAgc3dpdGNoIChvcHQpIHsKICAgICAgICAgY2FzZSAnZCc6CiAgICAgICAgIGkyY19k
ZXZuYW1lID0gb3B0YXJnOwogICAgICAgICBicmVhazsKICAgICAgY2FzZSAnYSc6CiAgICAgICAg
IGkyY19hZGRyID0gc3RydG91bChvcHRhcmcsIE5VTEwsIDE2KTsKICAgICAgICAgYnJlYWs7CiAg
ICAgIGNhc2UgJ20nOgogICAgICAgICBtb2RlID0gb3B0YXJnWzBdOwogICAgICAgICBicmVhazsK
ICAgICAgY2FzZSAnZic6CiAgICAgICAgIGZvcmNlID0xOwogICAgICAgICBicmVhazsKICAgICAg
Y2FzZSAnPyc6CiAgICAgIGNhc2UgJ2gnOgogICAgICBkZWZhdWx0OiAvKiAnPycgKi8KICAgICAg
ICAgdXNhZ2UoKTsKICAgICAgfQogICB9CgogICBpZiAoaTJjX2Rldm5hbWUgPT0gTlVMTCB8fCBp
MmNfYWRkciA9PSAtMSB8fCBtb2RlID09IC0xKSB7CiAgICAgIHVzYWdlKCk7CiAgIH0KCiAgIGky
Y19mZCA9IG9wZW4oaTJjX2Rldm5hbWUsIE9fUkRXUik7CiAgIGlmIChpMmNfZmQgPT0gLTEpIHsK
ICAgICAgZnByaW50ZihzdGRlcnIsICIlczolaSBvcGVuKCk6ICVzXG4iLCBfX0ZJTEVfXywgX19M
SU5FX18sIHN0cmVycm9yKGVycm5vKSk7CiAgICAgIGV4aXQoRVhJVF9GQUlMVVJFKTsKICAgfQoK
ICAgaWYgKGlvY3RsKGkyY19mZCwgZm9yY2UgPyBJMkNfU0xBVkVfRk9SQ0UgOiBJMkNfU0xBVkUs
IGkyY19hZGRyKSA8IDApIHsKICAgICAgZnByaW50ZihzdGRlcnIsICIlczolaSBpb2N0bCgpOiAl
c1xuIiwgX19GSUxFX18sIF9fTElORV9fLCBzdHJlcnJvcihlcnJubykpOwogICAgICBleGl0KEVY
SVRfRkFJTFVSRSk7CiAgIH0KCiAgIHN3aXRjaCAobW9kZSkgewogICAgICBjYXNlICd0JzoKICAg
ICAgICAgaWYgKGRzMzIzMV9nZXRfdGVtcHR1cmUoaTJjX2ZkLCAmdGVtcCkgPT0gMCkgCiAgICAg
ICAgICAgIHByaW50ZigiaW50XHQlZFxuIiwgdGVtcCk7CiAgICAgICAgICAgIHByaW50ZigiaW50
LT5pbnQxNl90XHQlZFxuIiwgKGludDE2X3QpdGVtcCk7CiAgICAgIGJyZWFrOwogICAgICBkZWZh
dWx0OgogICAgICAgICBmcHJpbnRmKHN0ZGVyciwgIlVuc3VwcG9ydGVkIG1vZGU6ICVjXG4iLCBt
b2RlKTsKICAgICAgICAgZXhpdChFWElUX0ZBSUxVUkUpOwogICB9CgogICByZXR1cm4oRVhJVF9T
VUNDRVNTKTsKfQo=
--089e012955ecaedcb205306cc3f7--
