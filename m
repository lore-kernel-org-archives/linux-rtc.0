Return-Path: <rtc-linux+bncBCKYNX7Y3IMBB4VF3HAAKGQEAOZJSZI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (up.free-electrons.com. [163.172.77.33])
        by gmr-mx.google.com with ESMTP id d64si537989wmh.2.2016.10.30.13.07.14
        for <rtc-linux@googlegroups.com>;
        Sun, 30 Oct 2016 13:07:14 -0700 (PDT)
Date: Sun, 30 Oct 2016 21:07:04 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Mauro Carvalho Chehab <mchehab@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mark Godfrey <mark.godfrey@stericsson.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	linux-arm-kernel@lists.infradead.org, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 1/2] ABI: rtc-ab8500: fix rtc_calibration documentation
Message-ID: <20161030200704.7skfbgt643kzmds4@piout.net>
References: <364a36215c44e0c2785911e9d9259cd866283cb9.1477735797.git.mchehab@s-opensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <364a36215c44e0c2785911e9d9259cd866283cb9.1477735797.git.mchehab@s-opensource.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 29/10/2016 at 08:10:02 -0200, Mauro Carvalho Chehab wrote :
> The "What:" field at the ABI should describe the location of
> the ABI, e. g. the position under a mounted sysfs.
> 
> Fix it.
> 
> Cc: Mark Godfrey <mark.godfrey@stericsson.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: rtc-linux@googlegroups.com
> Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> ---
>  .../ABI/testing/sysfs-class-rtc-rtc0-device-rtc_calibration          | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
