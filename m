Return-Path: <rtc-linux+bncBCMILY6JWQBBBD6U7W5AKGQEH5CKJ7A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from smtp.csie.ntu.edu.tw (smtp.csie.ntu.edu.tw. [140.112.30.61])
        by gmr-mx.google.com with ESMTPS id c11si1164069pfc.2.2016.06.13.19.21.03
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jun 2016 19:21:03 -0700 (PDT)
Received: from mail-it0-f51.google.com (mail-it0-f51.google.com [209.85.214.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: b93043)
	by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id EFBF420A00
	for <rtc-linux@googlegroups.com>; Tue, 14 Jun 2016 10:21:01 +0800 (CST)
Received: by mail-it0-f51.google.com with SMTP id e5so56971531ith.0
        for <rtc-linux@googlegroups.com>; Mon, 13 Jun 2016 19:21:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1465870678-30128-5-git-send-email-wens@csie.org>
References: <1465870678-30128-1-git-send-email-wens@csie.org> <1465870678-30128-5-git-send-email-wens@csie.org>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 14 Jun 2016 10:20:40 +0800
Message-ID: <CAGb2v66_SrKjQ_t_rL68QUVZQ=8hBoCTb8tbwCeBWz84kTabcQ@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 03/10] mfd: Add driver for X-Powers AC100
 audio codec / RTC combo IC
To: Chen-Yu Tsai <wens@csie.org>
Cc: Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, Rob Herring <robh+dt@kernel.org>,
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

On Tue, Jun 14, 2016 at 10:17 AM, Chen-Yu Tsai <wens@csie.org> wrote:
> The AC100 is a multifunction device with an audio codec subsystem and
> an RTC subsystem. These two subsystems share a common register space
> and host interface.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Self-NACK. A last minute fix up resulted in a compile error.

I'll send v2 later. Sorry for the noise.

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
