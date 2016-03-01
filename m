Return-Path: <rtc-linux+bncBDS7HNEFSALRB4VG263AKGQEXX7RV3Q@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id w10si9511wmw.3.2016.03.01.09.37.54
        for <rtc-linux@googlegroups.com>;
        Tue, 01 Mar 2016 09:37:54 -0800 (PST)
Date: Tue, 1 Mar 2016 18:37:43 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: vr41xx: remove unused function:
Message-ID: <20160301173743.GC23985@piout.net>
References: <1456851797-3510153-1-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1456851797-3510153-1-git-send-email-arnd@arndb.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Arnd,

On 01/03/2016 at 18:03:12 +0100, Arnd Bergmann wrote :
> The vr41xx_rtc_alarm_irq_enable function is never called
> has no effect other than producing a warning:
> 
> drivers/rtc/rtc-vr41xx.c:228:12: error: 'vr41xx_rtc_alarm_irq_enable' defined but not used [-Werror=unused-function]
> 
> This removes it.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

For that one, I took Geert's patch which makes use of the function and
is a proper fix.


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
