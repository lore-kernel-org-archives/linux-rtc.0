Return-Path: <rtc-linux+bncBCMILY6JWQBBBF63X65QKGQEN34Q3AA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from smtp.csie.ntu.edu.tw (smtp.csie.ntu.edu.tw. [140.112.30.61])
        by gmr-mx.google.com with ESMTPS id zj2si1780988pac.1.2016.06.26.07.58.30
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Jun 2016 07:58:31 -0700 (PDT)
Received: from mail-it0-f46.google.com (mail-it0-f46.google.com [209.85.214.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: b93043)
	by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id 260A920A01
	for <rtc-linux@googlegroups.com>; Sun, 26 Jun 2016 22:58:29 +0800 (CST)
Received: by mail-it0-f46.google.com with SMTP id a5so48664248ita.1
        for <rtc-linux@googlegroups.com>; Sun, 26 Jun 2016 07:58:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160626004557.GX5809@piout.net>
References: <1466391138-12862-1-git-send-email-wens@csie.org>
 <1466391138-12862-6-git-send-email-wens@csie.org> <20160626004557.GX5809@piout.net>
From: Chen-Yu Tsai <wens@csie.org>
Date: Sun, 26 Jun 2016 22:58:07 +0800
Message-ID: <CAGb2v64YnSz5MnnF==ZeeqZw4yBY2R=dNVdyi9BczVR5WCNZ3g@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH v3 5/8] rtc: ac100: Add clk output support
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>,
	rtc-linux@googlegroups.com, linux-kernel <linux-kernel@vger.kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Sun, Jun 26, 2016 at 8:45 AM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> On 20/06/2016 at 10:52:15 +0800, Chen-Yu Tsai wrote :
>> +struct ac100_clk32k {
>> +     struct clk_hw hw;
>> +     struct regmap *regmap;
>> +     u8 offset;
>> +};
>> +
>> +#define to_ac100_clk32k(_hw) container_of(_hw, struct ac100_clk32k, hw)
>> +
>> +#define AC100_RTC_32K_NAME   "ac100-rtc-32k"
>> +#define AC100_RTC_32K_RATE   32768
>> +#define AC100_ADDA_4M_NAME   "ac100-adda-4M"
>> +#define AC100_ADDA_4M_RATE   4000000
>> +#define AC100_CLK32K_NUM     3
>> +
>> +static const char * const ac100_clk32k_names[] = {
>> +     "ac100-clk32k-ap",
>> +     "ac100-clk32k-bb",
>> +     "ac100-clk32k-md",
>> +};
>> +
>
> Well, naming things is hard but I don't feel ac100_clk32k and
> ac100-clk32k are good prefixes for those clocks as they are actually
> dividing a 32KHz or 4MHz clock (one configuration out of 128 is 32KHz).

I agree it's a bit misleading. There are 2 names used throughout the
datasheet: 1) CKOn_RTC for the pin names, and 2) CLK32Kxx for the
register names and block diagram.

I'll switch to the pin names, since this is probably what is shown on
board schematics.

> Else, I don't have any objection.

Thanks!
ChenYu

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
