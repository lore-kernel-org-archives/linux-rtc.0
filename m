Return-Path: <rtc-linux+bncBCKYNX7Y3IMBB2WR3TBAKGQES6I7TXA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id e134si1014392wmd.3.2016.12.18.16.25.14
        for <rtc-linux@googlegroups.com>;
        Sun, 18 Dec 2016 16:25:14 -0800 (PST)
Date: Mon, 19 Dec 2016 01:25:13 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Volodymyr Bendiuga <volodymyr.bendiuga@westermo.se>
Cc: a.zummo@towertech.it, robh+dt@kernel.org, mark.rutland@arm.com,
	rtc-linux@googlegroups.com, devicetree@vger.kernel.org,
	volodymyr.bendiuga@gmail.com,
	Mattias =?iso-8859-1?Q?Walstr=F6m?= <mattias.walstrom@westermo.se>
Subject: Re: [rtc-linux] [PATCH] rtc: pcf8563: Do not disable clk out by default
Message-ID: <20161219002513.gxoe5csrzzvr6t7u@piout.net>
References: <1481295829-21974-1-git-send-email-volodymyr.bendiuga@westermo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1481295829-21974-1-git-send-email-volodymyr.bendiuga@westermo.se>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 09/12/2016 at 16:03:49 +0100, Volodymyr Bendiuga wrote :
> From: Mattias Walstr=C3=B6m <mattias.walstrom@westermo.se>
>=20
> Commit a39a6405d5f949bc651694028a disables CLKOUT of
> the rtc after power-up to improve power consumption.
> This is very useful, but some designs do require to
> have the rtc on all the time, otherwise devices will
> be bricked. Therefore this patch is a compromise that
> works for both cases, where the default case is when
> CLKOUT is on. If one wants to disable the CLKOUT,
> clkout-allow-disable can be added to devicetree's rtc node.
>=20

Actually, the commit description is misleading. The CCF is the one
disabling the clock if it is not used. If any user of the clock is
declared, it will not be disabled so it already works in both cases
(provided you have a proper driver getting the clock).

--=20
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

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
