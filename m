Return-Path: <rtc-linux+bncBCMILY6JWQBBBAWJVG5QKGQE3OBSL4I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from smtp.csie.ntu.edu.tw (smtp.csie.ntu.edu.tw. [140.112.30.61])
        by gmr-mx.google.com with ESMTPS id un17si6413850pab.0.2016.06.22.03.12.18
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jun 2016 03:12:18 -0700 (PDT)
Received: from mail-it0-f50.google.com (mail-it0-f50.google.com [209.85.214.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: b93043)
	by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id 4713120E72
	for <rtc-linux@googlegroups.com>; Wed, 22 Jun 2016 18:12:16 +0800 (CST)
Received: by mail-it0-f50.google.com with SMTP id f6so35099122ith.0
        for <rtc-linux@googlegroups.com>; Wed, 22 Jun 2016 03:12:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160622100206.GV26668@lukather>
References: <1466391138-12862-1-git-send-email-wens@csie.org>
 <1466391138-12862-6-git-send-email-wens@csie.org> <20160622100206.GV26668@lukather>
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 22 Jun 2016 18:11:55 +0800
Message-ID: <CAGb2v67DVBZbRb2PWLP8WurPaNin=2Fa=HMAEK_PdBeqv1x+8Q@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH v3 5/8] rtc: ac100: Add clk output support
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
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

On Wed, Jun 22, 2016 at 6:02 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Mon, Jun 20, 2016 at 10:52:15AM +0800, Chen-Yu Tsai wrote:
>> +     /*
>> +      * The ADDA 4 MHz clock is from the codec side of the AC100,
>> +      * which is likely a different power domain. However, boards
>> +      * always have both sides powered on, so it is impossible to
>> +      * test this.
>> +      */
>
> If that ADDA clock is exposed by the codec, why are you putting it in
> the RTC?

The thing is it's not entirely clear that it's from the codec side.
I'm just inferring this from the name. (I'll make the comment clearer.)
The codec parts of the datasheet don't mention this clock at all.

Allwinner's SDK puts all the clocks under the RTC module. And the
are always on, so I can't really turn off the codec and see what
happens. That and I don't have an oscilloscope or logic analyzer.

Regards
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
