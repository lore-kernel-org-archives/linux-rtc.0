Return-Path: <rtc-linux+bncBC4IFTUFXEFBBFN237DAKGQETVTALMQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wr0-x235.google.com (mail-wr0-x235.google.com. [2a00:1450:400c:c0c::235])
        by gmr-mx.google.com with ESMTPS id q207si716764wme.3.2017.03.26.08.24.05
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Mar 2017 08:24:05 -0700 (PDT)
Received: by mail-wr0-x235.google.com with SMTP id w43so11846674wrb.0
        for <rtc-linux@googlegroups.com>; Sun, 26 Mar 2017 08:24:05 -0700 (PDT)
Date: Sun, 26 Mar 2017 23:23:54 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Baptiste Reynal <b.reynal@virtualopensystems.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com, linux-arm-kernel@lists.infradead.org,
	kvm@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [rtc-linux] Re: [PATCH 1/5] Input: ambakmi - Convert to use devm_*()
Message-ID: <20170326152354.GA11555@leoy-linaro>
References: <1490539314-9681-1-git-send-email-leo.yan@linaro.org>
 <1490539314-9681-2-git-send-email-leo.yan@linaro.org>
 <20170326145023.GO7909@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170326145023.GO7909@n2100.armlinux.org.uk>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Sun, Mar 26, 2017 at 03:50:24PM +0100, Russell King - ARM Linux wrote:
> On Sun, Mar 26, 2017 at 10:41:50PM +0800, Leo Yan wrote:
> > Convert driver to use devm_*() APIs so rely on driver model core layer
> > to manage resources. This eliminates error path boilerplate and makes
> > code neat.
> > 
> > This patch also fixes the memory leakage for 'kmi->io' when remove
> > module.
> 
> No, it is not leaked, in fact, your patch introduces a use-after-free
> bug.
> 
> kmi->io is of type "struct serio", and this structure has an embedded
> "struct device".  The lifetime of any structure containing a "struct
> device" is controlled by the lifetime of the struct device.
> 
> Once serio_register_port() has been called on it, it is up to the
> serio layer to free this structure.
> 
> Therefore, your patch creates a bug, and so it gets a NAK.  There is no
> resource leakage here.

Thanks for reviewing. Now I understood and please ignore this patch
and patch 0005.

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
