Return-Path: <rtc-linux+bncBDE6RCFOWIARBVVD5TDAKGQEHLA7RMI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-it0-x232.google.com (mail-it0-x232.google.com. [2607:f8b0:4001:c0b::232])
        by gmr-mx.google.com with ESMTPS id a17si822323itd.1.2017.03.28.18.45.58
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Mar 2017 18:45:58 -0700 (PDT)
Received: by mail-it0-x232.google.com with SMTP id y18so136119566itc.0
        for <rtc-linux@googlegroups.com>; Tue, 28 Mar 2017 18:45:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1490539314-9681-3-git-send-email-leo.yan@linaro.org>
References: <1490539314-9681-1-git-send-email-leo.yan@linaro.org> <1490539314-9681-3-git-send-email-leo.yan@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 29 Mar 2017 03:45:57 +0200
Message-ID: <CACRpkdYHJinMhgUQLe3vf6P8hj3o_3ASi8pT+dtM5JtrE5ccJg@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 2/5] drivers/rtc/rtc-pl030.c: Convert to use devm_*()
To: Leo Yan <leo.yan@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Baptiste Reynal <b.reynal@virtualopensystems.com>,
	Alex Williamson <alex.williamson@redhat.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Linux Input <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, kvm@vger.kernel.org,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Sun, Mar 26, 2017 at 4:41 PM, Leo Yan <leo.yan@linaro.org> wrote:

> Convert driver to use devm_*() APIs so rely on driver model core layer
> to manage resources. This eliminates error path boilerplate and makes
> code neat.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
