Return-Path: <rtc-linux+bncBDS7HNEFSALRBAWDWCWQKGQEXXMSOYI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id fj7si273277wib.3.2015.07.19.15.15.30
        for <rtc-linux@googlegroups.com>;
        Sun, 19 Jul 2015 15:15:30 -0700 (PDT)
Date: Mon, 20 Jul 2015 00:15:27 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] Drop owner assignment from i2c_driver (and
 platform left-overs)
Message-ID: <20150719221527.GC15539@piout.net>
References: <1436510391-6001-1-git-send-email-k.kozlowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1436510391-6001-1-git-send-email-k.kozlowski@samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 10/07/2015 at 15:39:49 +0900, Krzysztof Kozlowski wrote :
> The i2c drivers also do not have to set 'owner' field because
> i2c_register_driver() will do it instead.
> 
> 'owner' is removed from i2c drivers, which I was able to compile
> with allyesconfig (arm, arm64, i386, x86_64, ppc64).
> Only compile-tested.
> 
> The coccinelle script which generated the patch was sent here:
> http://www.spinics.net/lists/kernel/msg2029903.html
> 
> 
> Best regards,
> Krzysztof
> 
> 
> Krzysztof Kozlowski (2):
>   rtc: Drop owner assignment from i2c_driver
>   rtc: Drop owner assignment from platform_driver
> 

Both applied, thanks!


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
