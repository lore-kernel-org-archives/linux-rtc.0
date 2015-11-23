Return-Path: <rtc-linux+bncBCMILY6JWQBBBWP3ZKZAKGQE2OQFPBI@googlegroups.com>
Received: from smtp.csie.ntu.edu.tw (smtp.csie.ntu.edu.tw. [140.112.30.61])
        by gmr-mx.google.com with ESMTP id pe1si790449pac.2.2015.11.22.23.18.49
        for <rtc-linux@googlegroups.com>;
        Sun, 22 Nov 2015 23:18:49 -0800 (PST)
Received: from mail-ig0-f170.google.com (mail-ig0-f170.google.com [209.85.213.170])
	(Authenticated sender: b93043)
	by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id 6A81C211F7
	for <rtc-linux@googlegroups.com>; Mon, 23 Nov 2015 15:18:48 +0800 (CST)
Received: by igcmv3 with SMTP id mv3so23370944igc.0
        for <rtc-linux@googlegroups.com>; Sun, 22 Nov 2015 23:18:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1447930210-27008-2-git-send-email-clabbe.montjoie@gmail.com>
References: <1447930210-27008-1-git-send-email-clabbe.montjoie@gmail.com> <1447930210-27008-2-git-send-email-clabbe.montjoie@gmail.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 23 Nov 2015 15:18:27 +0800
Message-ID: <CAGb2v65vNYg3zEmy+EesuDpfyLDuaCZ-rPPSjzTg4MaDGFGPnA@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 2/3] rtc: sunxi: constify the data_year_param structure
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
> The data_year_param struct is never modified, so lets constify it.
> This permit to remove cast since of_device_id is const also.
>
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

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
