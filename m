Return-Path: <rtc-linux+bncBC4IFTUFXEFBBGWB37DAKGQEIIZ4QRY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wr0-x236.google.com (mail-wr0-x236.google.com. [2a00:1450:400c:c0c::236])
        by gmr-mx.google.com with ESMTPS id a126si700692wmd.2.2017.03.26.08.39.05
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Mar 2017 08:39:05 -0700 (PDT)
Received: by mail-wr0-x236.google.com with SMTP id w11so11715714wrc.3
        for <rtc-linux@googlegroups.com>; Sun, 26 Mar 2017 08:39:05 -0700 (PDT)
Date: Sun, 26 Mar 2017 23:38:55 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
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
Message-ID: <20170326153855.GA14404@leoy-linaro>
References: <1490539314-9681-1-git-send-email-leo.yan@linaro.org>
 <20170326152050.v47z36eud6xvrcpt@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170326152050.v47z36eud6xvrcpt@piout.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Sun, Mar 26, 2017 at 05:20:50PM +0200, Alexandre Belloni wrote:
> On 26/03/2017 at 22:41:49 +0800, Leo Yan wrote:
> > When review device driver modules which attach to amba bus, found
> > several modules are not using devm_*() apis to manage resource. As
> > result, some drivers have memory leakage or missing iomem unmapping
> > when rmmod module. And the code has many "goto" tags to handle
> > different failures.
> > 
> > So this patch series is to convert to use devm_*() for moudules which
> > are attached to amba bus to manage resource and get more robust and
> > neat code.
> > 
> > Patch 0003 "drivers/rtc/rtc-pl031.c: Convert to use devm_*()" has been
> > verified on 96boards Hikey. Other patches can pass building but have
> > not really tested on hardware.
> > 
> 
> If your plan is to actually remove usage of
> amba_request_regions() and amba_release_regions(), you should do so in
> its own patch sets instead of hiding that in a useless cleanup series.

Just curious, from Russell's replying for patch 0005, IIUC we cannot
totally remove usage of amba_request_regions() and
amba_release_regions(), there have some coner case should use
amba_request_regions() + ioremap().

Does it make sense to remove most usage of amba_request_regions() and
amba_release_regions() but we still keep these two functions in the kernel?

Thanks,
Leo Yan

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
