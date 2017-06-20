Return-Path: <rtc-linux+bncBAABBRE4U3FAKGQENB6EGNY@googlegroups.com>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk. [2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by gmr-mx.google.com with ESMTPS id o27si3384612wmi.4.2017.06.20.14.06.11
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 14:06:11 -0700 (PDT)
Date: Tue, 20 Jun 2017 22:05:58 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	linaro-kernel <linaro-kernel@lists.linaro.org>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: [rtc-linux] Re: [PATCH 34/51] rtc: pl031: stop using rtc deprecated functions
Message-ID: <20170620210558.GL4902@n2100.armlinux.org.uk>
References: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
 <1497951359-13334-35-git-send-email-benjamin.gaignard@linaro.org>
 <CACRpkdZsdwuytW5RHSdd5t9MSyYnhV1nNNKOR1VUzqEgicFqUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <CACRpkdZsdwuytW5RHSdd5t9MSyYnhV1nNNKOR1VUzqEgicFqUw@mail.gmail.com>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, Jun 20, 2017 at 06:08:48PM +0200, Linus Walleij wrote:
> On Tue, Jun 20, 2017 at 11:35 AM, Benjamin Gaignard
> <benjamin.gaignard@linaro.org> wrote:
> 
> > rtc_time_to_tm() and rtc_tm_to_time() are deprecated because they
> > rely on 32bits variables and that will make rtc break in y2038/2016.
> > Stop using those two functions to safer 64bits ones.
> >
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> > CC: Linus Walleij <linus.walleij@linaro.org>
> > CC: Alessandro Zummo <a.zummo@towertech.it>
> > CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > CC: rtc-linux@googlegroups.com
> > CC: linux-kernel@vger.kernel.org
> > CC: linux-arm-kernel@lists.infradead.org
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Naked-again-by: Russell King

Really, people need to stop re-posting the same patches that have
already been naked.

This patch fixes NOTHING.

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
