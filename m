Return-Path: <rtc-linux+bncBAABBT5K37DAKGQEB6ILMEI@googlegroups.com>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk. [2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by gmr-mx.google.com with ESMTPS id q207si711558wme.3.2017.03.26.07.50.55
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 26 Mar 2017 07:50:55 -0700 (PDT)
Date: Sun, 26 Mar 2017 15:50:24 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Leo Yan <leo.yan@linaro.org>
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
Message-ID: <20170326145023.GO7909@n2100.armlinux.org.uk>
References: <1490539314-9681-1-git-send-email-leo.yan@linaro.org>
 <1490539314-9681-2-git-send-email-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1490539314-9681-2-git-send-email-leo.yan@linaro.org>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Sun, Mar 26, 2017 at 10:41:50PM +0800, Leo Yan wrote:
> Convert driver to use devm_*() APIs so rely on driver model core layer
> to manage resources. This eliminates error path boilerplate and makes
> code neat.
> 
> This patch also fixes the memory leakage for 'kmi->io' when remove
> module.

No, it is not leaked, in fact, your patch introduces a use-after-free
bug.

kmi->io is of type "struct serio", and this structure has an embedded
"struct device".  The lifetime of any structure containing a "struct
device" is controlled by the lifetime of the struct device.

Once serio_register_port() has been called on it, it is up to the
serio layer to free this structure.

Therefore, your patch creates a bug, and so it gets a NAK.  There is no
resource leakage here.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
