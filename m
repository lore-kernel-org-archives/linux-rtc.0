Return-Path: <rtc-linux+bncBDS7HNEFSALRB6NI223AKGQE24BX5WY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id w10si786832wmw.3.2016.03.01.05.09.13
        for <rtc-linux@googlegroups.com>;
        Tue, 01 Mar 2016 05:09:13 -0800 (PST)
Date: Tue, 1 Mar 2016 14:09:12 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Yoichi Yuasa <yuasa@linux-mips.org>,
	John Stultz <john.stultz@linaro.org>, rtc-linux@googlegroups.com,
	linux-mips@linux-mips.org
Subject: [rtc-linux] Re: [PATCH/RFT] rtc: rtc-vr41xx: Wire up alarm_irq_enable
Message-ID: <20160301130912.GH2627@piout.net>
References: <1456822201-12408-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1456822201-12408-1-git-send-email-geert@linux-m68k.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 01/03/2016 at 09:50:01 +0100, Geert Uytterhoeven wrote :
> drivers/rtc/rtc-vr41xx.c:229: warning: =E2=80=98vr41xx_rtc_alarm_irq_enab=
le=E2=80=99 defined but not used
>=20
> Apparently the conversion to alarm_irq_enable forgot to wire up the
> callback.
>=20
> Fixes: 16380c153a69c378 ("RTC: Convert rtc drivers to use the alarm_irq_e=
nable method")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Applied, thanks.

--=20
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--=20
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
