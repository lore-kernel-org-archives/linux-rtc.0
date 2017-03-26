Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBU5Y37DAKGQEYVMDAPA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id q207si716570wme.3.2017.03.26.08.20.51
        for <rtc-linux@googlegroups.com>;
        Sun, 26 Mar 2017 08:20:51 -0700 (PDT)
Date: Sun, 26 Mar 2017 17:20:50 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Leo Yan <leo.yan@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Linus Walleij <linus.walleij@linaro.org>,
	Baptiste Reynal <b.reynal@virtualopensystems.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com, linux-arm-kernel@lists.infradead.org,
	kvm@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [rtc-linux] Re: [PATCH 0/5] Convert to use devm_*() for amba attached modules
Message-ID: <20170326152050.v47z36eud6xvrcpt@piout.net>
References: <1490539314-9681-1-git-send-email-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1490539314-9681-1-git-send-email-leo.yan@linaro.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 26/03/2017 at 22:41:49 +0800, Leo Yan wrote:
> When review device driver modules which attach to amba bus, found
> several modules are not using devm_*() apis to manage resource. As
> result, some drivers have memory leakage or missing iomem unmapping
> when rmmod module. And the code has many "goto" tags to handle
> different failures.
> 
> So this patch series is to convert to use devm_*() for moudules which
> are attached to amba bus to manage resource and get more robust and
> neat code.
> 
> Patch 0003 "drivers/rtc/rtc-pl031.c: Convert to use devm_*()" has been
> verified on 96boards Hikey. Other patches can pass building but have
> not really tested on hardware.
> 

If your plan is to actually remove usage of
amba_request_regions() and amba_release_regions(), you should do so in
its own patch sets instead of hiding that in a useless cleanup series.

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
