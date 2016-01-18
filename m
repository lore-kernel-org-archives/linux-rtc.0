Return-Path: <rtc-linux+bncBD2OLRXW4ABBBIVQ6O2AKGQEW25N2XA@googlegroups.com>
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com. [216.228.121.64])
        by gmr-mx.google.com with ESMTPS id i25si2334140pfj.2.2016.01.18.04.18.42
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2016 04:18:42 -0800 (PST)
Message-ID: <569CD5A7.1090407@nvidia.com>
Date: Mon, 18 Jan 2016 17:38:07 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Linus Walleij <linus.walleij@linaro.org>
CC: Lee Jones <lee.jones@linaro.org>, Julia Lawall <julia.lawall@lip6.fr>, Rob
 Herring <robh+dt@kernel.org>, =?UTF-8?B?UGF3ZcWCIE1vbGw=?=
	<pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, Kumar Gala
	<galak@codeaurora.org>, Alexandre Courbot <gnurou@gmail.com>, Mark Brown
	<broonie@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre
 Belloni <alexandre.belloni@free-electrons.com>, Liam Girdwood
	<lgirdwood@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, "rtc-linux@googlegroups.com"
	<rtc-linux@googlegroups.com>, Stephen Warren <swarren@nvidia.com>, Thierry
 Reding <treding@nvidia.com>, Chaitanya Bandi <bandik@nvidia.com>
Subject: [rtc-linux] Re: [PATCH] gpio: max77620: fix of_table.cocci warnings
References: <alpine.DEB.2.10.1601111146380.2512@hadrien>	<CACRpkdbUG_cR8AZt0HmiNApy+g3Xy58BkjFXST-1gNqXqYJvGw@mail.gmail.com>	<20160114094742.GC28745@x1>	<56976CE7.8070708@nvidia.com> <CACRpkdaV6e2SeAGE5C6_W6_0qbwMG6RaL+b+8o+JoyuJR-Y=Hg@mail.gmail.com>
In-Reply-To: <CACRpkdaV6e2SeAGE5C6_W6_0qbwMG6RaL+b+8o+JoyuJR-Y=Hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


On Friday 15 January 2016 06:45 PM, Linus Walleij wrote:
> On Thu, Jan 14, 2016 at 10:39 AM, Laxman Dewangan <ldewangan@nvidia.com> wrote:
>> I think still there is discussion going on the patches?
> Sure let's work on this for the next cycle.
>
>

I have fixed this in V3 version and sent for review.
Please help to review it.

Thanks,
Laxman

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
