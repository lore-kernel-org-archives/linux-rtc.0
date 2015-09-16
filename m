Return-Path: <rtc-linux+bncBCZ7NMHQ3YLRBCNA42XQKGQEJDYWYYA@googlegroups.com>
Received: from mail-wi0-x22c.google.com (mail-wi0-x22c.google.com. [2a00:1450:400c:c05::22c])
        by gmr-mx.google.com with ESMTPS id k7si5415wif.1.2015.09.16.08.51.37
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2015 08:51:37 -0700 (PDT)
Received: by mail-wi0-x22c.google.com with SMTP id lk2so77362506wic.1
        for <rtc-linux@googlegroups.com>; Wed, 16 Sep 2015 08:51:37 -0700 (PDT)
MIME-Version: 1.0
From: Ivan Grimaldi <grimaldi.ivan@gmail.com>
Date: Wed, 16 Sep 2015 17:51:17 +0200
Message-ID: <CAO1575Wk_O6RYMGJSx2=54OYj-_fZXSGum5bZa8fF=cpf5d5Gw@mail.gmail.com>
Subject: [rtc-linux] [PATCH] Fixed ds1390_get_reg returned value
To: Alessandro Zummo <a.zummo@towertech.it>, Mark Jackson <mpfj@mimc.co.uk>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary=047d7bf198a010f2a7051fdf469d
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

--047d7bf198a010f2a7051fdf469d
Content-Type: text/plain; charset=UTF-8

spi_write_then_read puts in rx_buf the received data starting from the
first byte of the rx_buf for n_rx bytes.

Signed-off-by: Ivan Grimaldi <grimaldi.ivan@gmail.com>
---
diff --git a/drivers/rtc/rtc-ds1390.c b/drivers/rtc/rtc-ds1390.c
index e67bfcb..a4303b4 100644
--- a/drivers/rtc/rtc-ds1390.c
+++ b/drivers/rtc/rtc-ds1390.c
@@ -62,7 +62,7 @@ static int ds1390_get_reg(struct device *dev, unsigned
char address,
        if (status != 0)
                return status;

-       *data = chip->txrx_buf[1];
+       *data = chip->txrx_buf[0];

        return 0;
 }

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

--047d7bf198a010f2a7051fdf469d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">spi_write_then_read puts in rx_buf the received data start=
ing from the first byte of the rx_buf for n_rx bytes.<br><br>Signed-off-by:=
 Ivan Grimaldi &lt;<a href=3D"mailto:grimaldi.ivan@gmail.com">grimaldi.ivan=
@gmail.com</a>&gt;<br><div>---<br>diff --git a/drivers/rtc/rtc-ds1390.c b/d=
rivers/rtc/rtc-ds1390.c<br>index e67bfcb..a4303b4 100644<br>--- a/drivers/r=
tc/rtc-ds1390.c<br>+++ b/drivers/rtc/rtc-ds1390.c<br>@@ -62,7 +62,7 @@ stat=
ic int ds1390_get_reg(struct device *dev, unsigned char address,<br>=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (status !=3D 0)<br>=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 return status;<br>=C2=A0<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *data =
=3D chip-&gt;txrx_buf[1];<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *data =
=3D chip-&gt;txrx_buf[0];<br>=C2=A0<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return 0;<br>=C2=A0}<br></div></div>

<p></p>

-- <br />
-- <br />
You received this message because you are subscribed to &quot;rtc-linux&quo=
t;.<br />
Membership options at <a href=3D"http://groups.google.com/group/rtc-linux">=
http://groups.google.com/group/rtc-linux</a> .<br />
Please read <a href=3D"http://groups.google.com/group/rtc-linux/web/checkli=
st">http://groups.google.com/group/rtc-linux/web/checklist</a><br />
before submitting a driver.<br />
--- <br />
You received this message because you are subscribed to the Google Groups &=
quot;rtc-linux&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:rtc-linux+unsubscribe@googlegroups.com">rtc-linux=
+unsubscribe@googlegroups.com</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

--047d7bf198a010f2a7051fdf469d--
