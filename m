Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0AFC48BDF
	for <linux-rtc@archiver.kernel.org>; Sun, 20 Jun 2021 22:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD3B9611AC
	for <linux-rtc@archiver.kernel.org>; Sun, 20 Jun 2021 22:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhFTWLP (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sun, 20 Jun 2021 18:11:15 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:58653 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhFTWLO (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 20 Jun 2021 18:11:14 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 7EC57C0006;
        Sun, 20 Jun 2021 22:09:00 +0000 (UTC)
Date:   Mon, 21 Jun 2021 00:08:59 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Cedric.dewijs@eclipso.eu
Cc:     linux-rtc@vger.kernel.org
Subject: Re: out of tree rtc driver RX8900CE, has anybody updated it to the
 new v5 kernel interface?
Message-ID: <YM+8e1NzNcc+DhR+@piout.net>
References: <721fdcefb1cb3932cd0b715b2f689c8d@mail.eclipso.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <721fdcefb1cb3932cd0b715b2f689c8d@mail.eclipso.de>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hello,

This is a late reply (I forgot about this email) but have you seen
drivers/rtc/rtc-rv8803.c ?

Regards,

On 24/01/2021 15:07:52+0100,   wrote:
> ­Hi All,
> 
> I have a RX8900CE rtc, connected to the i2c bus of a raspberry pi. I've gotten a kernel module from the manufacturer of the chip [1][2], it's based on the kernel module for the RX-8025 [3]. I've compiled it with this makefile [4]:
> 
> This all worked without any problem, in kernel 4.19.76 but in newer kernels the structure of the rtc drivers has changed.
> 
> Has anybody already converted the RX8900CE driver to the new kernel interface?
> After I update the kernel module, what steps do I have to take so it can be included in the mainline kernel?
> 
> Cheers,
> Cedric
> 
> 
> [1] https://www5.epsondevice.com/en/information/support/linux_rtc/down_load.html
> [2] https://www5.epsondevice.com/en/information/support/soft/rx8900_k3.8-v1.0.zip
> [3] https://github.com/torvalds/linux/blob/master/drivers/rtc/rtc-rx8025.c
> [4] 
> RX8900_DIR = $(shell pwd)
> KSRC = /lib/modules/$(KVER)/build
> KVER = $(shell uname -r)
> MODDESTDIR = /lib/modules/$(KVER)/kernel/drivers/rtc
> 
> CROSS_COMPILE	=
> 
> AS              = $(CROSS_COMPILE)as
> LD              = $(CROSS_COMPILE)ld
> CC              = $(CROSS_COMPILE)gcc
> CPP             = $(CC) -E
> AR              = $(CROSS_COMPILE)ar
> NM              = $(CROSS_COMPILE)nm
> STRIP           = $(CROSS_COMPILE)strip
> OBJCOPY         = $(CROSS_COMPILE)objcopy
> OBJDUMP         = $(CROSS_COMPILE)objdump
> DEPMOD          = /sbin/depmod
> INSTALL			= /usr/bin/install
> GREP			= /bin/grep
> 
> obj-m += rtc-rx8900.o
> 
> all:
> 	modules
> 
> modules:
> 	$(MAKE) -C $(KSRC) M=$(RX8900_DIR) CC=$(CC) modules
> 
> install: modules
> 	@$(GREP) rtc-rx8900.ko /lib/modules/$(shell uname -r)/modules.dep && rm -fr $(MODDESTDIR)/rtc-rx8900.ko || echo "No system rtc-rx8900.ko file found. Install the new rtc-rx8900.ko driver into the system"
> 	$(INSTALL) -p -m 644 rtc-rx8900.ko $(MODDESTDIR)
> 	@$(DEPMOD) -a
> 	
> uninstall:
> 	@$(GREP) rtc-rx8900.ko /lib/modules/$(shell uname -r)/modules.dep && rm -fr $(MODDESTDIR)/rtc-rx8900.ko || echo "Remove the rtc-rx8900.ko driver from the system"
> 	@$(DEPMOD) -a
> 	
> clean:
> 	$(MAKE) -C $(KSRC) M=$(RX8900_DIR) CC=$(CC) clean
> 
> 
> ---
> 
> Take your mailboxes with you. Free, fast and secure Mail &amp; Cloud: https://www.eclipso.eu - Time to change!
> 
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
