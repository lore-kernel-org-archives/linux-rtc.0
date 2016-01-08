Return-Path: <rtc-linux+bncBDJIP47K7MERBEMLX62AKGQEI6FLNOY@googlegroups.com>
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTP id a76si336152pfj.2.2016.01.08.06.20.01
        for <rtc-linux@googlegroups.com>;
        Fri, 08 Jan 2016 06:20:01 -0800 (PST)
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 78B1B2010E
	for <rtc-linux@googlegroups.com>; Fri,  8 Jan 2016 14:20:00 +0000 (UTC)
Received: from mail-yk0-f171.google.com (mail-yk0-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 8F46B201EF
	for <rtc-linux@googlegroups.com>; Fri,  8 Jan 2016 14:19:57 +0000 (UTC)
Received: by mail-yk0-f171.google.com with SMTP id k129so340758966yke.0
        for <rtc-linux@googlegroups.com>; Fri, 08 Jan 2016 06:19:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <568F51FF.7000102@nvidia.com>
References: <1452177524-23192-1-git-send-email-ldewangan@nvidia.com>
 <1452177524-23192-2-git-send-email-ldewangan@nvidia.com> <20160107231249.GA17514@rob-hp-laptop>
 <568F51FF.7000102@nvidia.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 8 Jan 2016 08:19:37 -0600
Message-ID: <CAL_JsqJ=bhFF2X-LHFtboWFP3Ch=W8VBr2gv1EFRTb4EgtM=2w@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 1/6] DT: mfd: add device-tree binding doc fro
 PMIC max77620/max20024
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
	Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>,
	Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, Liam Girdwood <lgirdwood@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"open list:REAL TIME CLOCK (RTC) SUBSYSTEM" <rtc-linux@googlegroups.com>, Stephen Warren <swarren@nvidia.com>,
	Thierry Reding <treding@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Fri, Jan 8, 2016 at 12:06 AM, Laxman Dewangan <ldewangan@nvidia.com> wrote:
> Thanks Rob for review.
> I have taken care of all comment except following which I have query.
>
> On Friday 08 January 2016 04:42 AM, Rob Herring wrote:
>>
>> +       - maxim,low-battery-reset-enable: Enable low battery reset.
>> +       - maxim,low-battery-reset-disable: Disable low battery reset.
>> Why not boolean? Not present means keep default value? I'd prefer
>> boolean or tristate of not present, 0 to disable, or 1 to enable.
>>
>>
> Here, the properties are boolean. I will add this on the description.
>
> I like to enable or disable with the DT and properties are not there then
> left to default.
> So added two properties for enable and disable. If properties are there, do
> the activity.
>
> Here tristate is also possible:
> maxim,low-battery-reset: tristate, low battery reset control. 0 for disable,
> 1 for enable and
>                                  absence of this will leave configuration on
> default.
>
> Does it look fine?

Yes.

Rob

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
