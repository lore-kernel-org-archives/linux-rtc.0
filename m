Return-Path: <rtc-linux+bncBDS7HNEFSALRBIVS66VQKGQEJPGKI7Q@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id h1si392624wiw.1.2015.06.14.12.42.25
        for <rtc-linux@googlegroups.com>;
        Sun, 14 Jun 2015 12:42:25 -0700 (PDT)
Date: Sun, 14 Jun 2015 21:42:24 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: hym8563: make the irq optional
Message-ID: <20150614194224.GA17679@piout.net>
References: <2559079.JyXCpe7EYV@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <2559079.JyXCpe7EYV@diego>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 13/06/2015 at 12:34:04 +0200, Heiko St=C3=BCbner wrote :
> Sometimes the irq line is not connected to any soc-pin. This does
> not hinder basic timekeeping functionality of the rtc, so probe
> should not fail in this case.
>=20
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  .../devicetree/bindings/rtc/haoyu,hym8563.txt          |  2 +-
>  drivers/rtc/rtc-hym8563.c                              | 18 ++++++++++--=
------
>  2 files changed, 11 insertions(+), 9 deletions(-)
>=20
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
