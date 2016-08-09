Return-Path: <rtc-linux+bncBCJLBW6OUMMRBUMOU66QKGQED4JXXVA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from smtp.smtpout.orange.fr (smtp11.smtpout.orange.fr. [80.12.242.133])
        by gmr-mx.google.com with ESMTPS id w64si128337wmf.3.2016.08.09.04.58.35
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 09 Aug 2016 04:58:35 -0700 (PDT)
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [rtc-linux] [PATCH] rtc: pcf2123: Add missing error code assignment
 before test
Date: Tue,  9 Aug 2016 13:58:27 +0200
Message-Id: <1470743907-11498-1-git-send-email-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

It is likely that checking the result of 'pcf2123_write_reg' is expected
here.
Also fix a small style issue. The '{' at the beginning of the function
is misplaced.

Fixes: 809b453b76e15 ("rtc: pcf2123: clean up writes to the rtc chip")

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/rtc/rtc-pcf2123.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2123.c b/drivers/rtc/rtc-pcf2123.c
index b4478cc92b55..8895f77726e8 100644
--- a/drivers/rtc/rtc-pcf2123.c
+++ b/drivers/rtc/rtc-pcf2123.c
@@ -182,7 +182,8 @@ static ssize_t pcf2123_show(struct device *dev, struct =
device_attribute *attr,
 }
=20
 static ssize_t pcf2123_store(struct device *dev, struct device_attribute *=
attr,
-			     const char *buffer, size_t count) {
+			     const char *buffer, size_t count)
+{
 	struct pcf2123_sysfs_reg *r;
 	unsigned long reg;
 	unsigned long val;
@@ -199,7 +200,7 @@ static ssize_t pcf2123_store(struct device *dev, struct=
 device_attribute *attr,
 	if (ret)
 		return ret;
=20
-	pcf2123_write_reg(dev, reg, val);
+	ret =3D pcf2123_write_reg(dev, reg, val);
 	if (ret < 0)
 		return -EIO;
 	return count;
--=20
2.7.4


---
L'absence de virus dans ce courrier =C3=A9lectronique a =C3=A9t=C3=A9 v=C3=
=A9rifi=C3=A9e par le logiciel antivirus Avast.
https://www.avast.com/antivirus

--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
