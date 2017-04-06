Return-Path: <rtc-linux+bncBC4IFTUFXEFBBC44THDQKGQEETMFSBY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-pg0-x235.google.com (mail-pg0-x235.google.com. [2607:f8b0:400e:c05::235])
        by gmr-mx.google.com with ESMTPS id i189si269898pfg.3.2017.04.06.07.17.46
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Apr 2017 07:17:46 -0700 (PDT)
Received: by mail-pg0-x235.google.com with SMTP id 21so37352284pgg.1
        for <rtc-linux@googlegroups.com>; Thu, 06 Apr 2017 07:17:46 -0700 (PDT)
Date: Thu, 6 Apr 2017 22:17:31 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Auger Eric <eric.auger@redhat.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Baptiste Reynal <b.reynal@virtualopensystems.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com, linux-arm-kernel@lists.infradead.org,
	kvm@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [rtc-linux] Re: [PATCH 4/5] vfio: platform: Convert to use devm_*()
Message-ID: <20170406141731.GA27245@leoy-linaro>
References: <1490539314-9681-1-git-send-email-leo.yan@linaro.org>
 <1490539314-9681-5-git-send-email-leo.yan@linaro.org>
 <10625a88-3d6d-de52-8299-3ba0031317f8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <10625a88-3d6d-de52-8299-3ba0031317f8@redhat.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Sun, Apr 02, 2017 at 04:45:28PM +0200, Auger Eric wrote:
> Hi Leo,
> 
> On 26/03/2017 16:41, Leo Yan wrote:
> > Convert driver to use devm_*() APIs so rely on driver model core layer
> > to manage resources. This eliminates error path boilerplate and makes
> > code neat.
> > 
> > This patch also renames amba_id structure, the old code used some code
> > which directly copied from other driver.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Looks good to me
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks for reviewing, Eric.

> May be interesting to go further converting as well the vfio-platform
> driver but this can be done later on.

Looked a bit for vfio-platform driver and I'm not sure if need some
converting within function vfio_platform_probe_common(). So I'd like
to leave this to who really understand the subsystem :)

[...]

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
