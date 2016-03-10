Return-Path: <rtc-linux+bncBDS7HNEFSALRBZXVQO3QKGQEZ4I3OYY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id z75si66941wmz.2.2016.03.09.20.41.10
        for <rtc-linux@googlegroups.com>;
        Wed, 09 Mar 2016 20:41:10 -0800 (PST)
Date: Thu, 10 Mar 2016 05:41:07 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Kyle McMartin <kyle@mcmartin.ca>,
	rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Subject: [rtc-linux] Re: [PATCH 0/6] rtc: generic: follow up for COMPILE_TEST
Message-ID: <20160310044107.GD9868@piout.net>
References: <1456851608-3374907-1-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1456851608-3374907-1-git-send-email-arnd@arndb.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 01/03/2016 at 17:59:56 +0100, Arnd Bergmann wrote :
> Today's linux-next kernel allowed building the rtc-generic
> driver (and most other rtc drivers) on all architectures,
> but this caused some errors on architectures without asm/rtc.h.
> 
> This series reworks that driver to avoid the dependency,
> and simplifies all four implementations. My first approach
> was to split the driver into four separate drivers, but
> that didn't feel right when three of them have their own
> multiplexors.
> 
> The first five patches can be applied independent of one other,
> while patch 6 is optional and can be applied when all others
> are merged. Alternatively, they can all go in through the
> rtc tree. I compile-tested only the powerpc and sh targets for
> which I happened to have cross-compilers installed.
> 

I like this approach. Maybe you can also remove the now unnecessary
definitions from the various asm/rtc.h.

I have a small nitpick on the parisc patch.

I'll take the first patch, no need to resend that one.

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
