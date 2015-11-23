Return-Path: <rtc-linux+bncBCMILY6JWQBBBRH3ZKZAKGQEAB6KV7Q@googlegroups.com>
Received: from smtp.csie.ntu.edu.tw (smtp.csie.ntu.edu.tw. [140.112.30.61])
        by gmr-mx.google.com with ESMTP id fg10si903968pad.0.2015.11.22.23.18.27
        for <rtc-linux@googlegroups.com>;
        Sun, 22 Nov 2015 23:18:27 -0800 (PST)
Received: from mail-ig0-f171.google.com (mail-ig0-f171.google.com [209.85.213.171])
	(Authenticated sender: b93043)
	by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id 6B7CF21469
	for <rtc-linux@googlegroups.com>; Mon, 23 Nov 2015 15:18:26 +0800 (CST)
Received: by igl9 with SMTP id 9so45826303igl.0
        for <rtc-linux@googlegroups.com>; Sun, 22 Nov 2015 23:18:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1447930210-27008-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1447930210-27008-1-git-send-email-clabbe.montjoie@gmail.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 23 Nov 2015 15:18:05 +0800
Message-ID: <CAGb2v66odj__GMWy8sgc0b5df5FR1V3p-EhL2f-QMM8krA3Oqg@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 1/3] rtc: sunxi: fix signedness issues
To: LABBE Corentin <clabbe.montjoie@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Thu, Nov 19, 2015 at 6:50 PM, LABBE Corentin
<clabbe.montjoie@gmail.com> wrote:
> The variable year must be set as unsigned since it is used with
> sunxi_rtc_data_year{.min|.max} and as parameter of is_leap_year() which
> wait for unsigned int.
> Only tm_year is not unsigned, but it is long.
> This patch fix also the format of printing of min/max. (must use %u since
> they are unsigned)
>
> The parameter to of sunxi_rtc_setaie() must be set to uint since callers
> give always uint data.
>
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

Would've preferred you not changing the whitespace on the dev_err line though.

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
