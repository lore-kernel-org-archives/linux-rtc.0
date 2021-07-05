Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB67C07E99
	for <linux-rtc@archiver.kernel.org>; Mon,  5 Jul 2021 12:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF5E26135C
	for <linux-rtc@archiver.kernel.org>; Mon,  5 Jul 2021 12:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhGEMQj (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:16:39 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38380 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbhGEMQi (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 5 Jul 2021 08:16:38 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1A4B41FE5C;
        Mon,  5 Jul 2021 12:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625487241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=46q8UclYEn65a49RzxpKI/3dVSD5yV+XW8jxkT70lDk=;
        b=LwLfYCWKW/+5x3vgXSk4vBGsNTUGns4tt3Ud3OyKzn7K5g+KzJYN8Yu07Ynr8pqE4+z30E
        MZyclKrwb6AFIM9xtCy1Q5JIGshdf+CLJ1YhIDTkzWgI6o9ibc9SS3V0mYkyiqhbqL+eEj
        gtnOoUcSEAvihBdV74gm4+zm+HxGxe8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625487241;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=46q8UclYEn65a49RzxpKI/3dVSD5yV+XW8jxkT70lDk=;
        b=NTXYH5qbA8GHY18kHZKtGWZKIrplep033FoShY4rOZHApntK9+lG4iZ+jcKmqkOOArqKSD
        5j0pF7pKadwqBnBg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id D301B1367E;
        Mon,  5 Jul 2021 12:14:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id j9VzMYj34mCaFQAAGKfGzw
        (envelope-from <ykaukab@suse.de>); Mon, 05 Jul 2021 12:14:00 +0000
Date:   Mon, 5 Jul 2021 14:13:55 +0200
From:   Mian Yousaf Kaukab <ykaukab@suse.de>
To:     Bruno Thomsen <bruno.thomsen@gmail.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>, biwen.li@nxp.com
Subject: Re: [PATCH v6] rtc: pcf2127: handle timestamp interrupts
Message-ID: <20210705121355.GA82146@suse.de>
References: <20210629150643.31551-1-ykaukab@suse.de>
 <CAH+2xPAYD--=RWHTw8yuUGb7xKWUd+hGo7QHCsKzz8BNzNwUbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH+2xPAYD--=RWHTw8yuUGb7xKWUd+hGo7QHCsKzz8BNzNwUbA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Wed, Jun 30, 2021 at 08:26:04PM +0200, Bruno Thomsen wrote:
> Den tir. 29. jun. 2021 kl. 17.06 skrev Mian Yousaf Kaukab <ykaukab@suse.de>:
> >
> > commit 03623b4b041c ("rtc: pcf2127: add tamper detection support")
> > added support for timestamp interrupts. However they are not being
> > handled in the irq handler. If a timestamp interrupt occurs it
> > results in kernel disabling the interrupt and displaying the call
> > trace:
> >
> > [  121.145580] irq 78: nobody cared (try booting with the "irqpoll" option)
> > ...
> > [  121.238087] [<00000000c4d69393>] irq_default_primary_handler threaded [<000000000a90d25b>] pcf2127_rtc_irq [rtc_pcf2127]
> > [  121.248971] Disabling IRQ #78
> >
> > Handle timestamp interrupts in pcf2127_rtc_irq(). Save time stamp
> > before clearing TSF1 and TSF2 flags so that it can't be overwritten.
> > Set a flag to mark if the timestamp is valid and only report to sysfs
> > if the flag is set. To mimic the hardware behavior, don’t save
> > another timestamp until the first one has been read by the userspace.
> >
> > However, if the alarm irq is not configured, keep the old way of
> > handling timestamp interrupt in the timestamp0 sysfs calls.
> >
> > Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> > ---
> > Sorry, once again compile tested only due to lack of hardware
> > availability. Hopefully, I will be able to do some real tests tomorrow.
> 
> Hi Yousaf,
> 
> I have tested patch version 6 on an imx7 board with the pcf2127
> chip using SPI interface and no alarm IRQ in the device tree.
> The same board that produced an oops earlier, and now it's working
> as expected. Both tamper events that occur when the device is
> powered on and when an event happens with the device powered off.
> 
> Reviewed-by: Bruno Thomsen <bruno.thomsen@gmail.com>
> Tested-by: Bruno Thomsen <bruno.thomsen@gmail.com>
Thank you for reviewing and testing the patch!
I have tested it with alarm irq configured and it works fine.

Alexandre, is it still possible to queue for v5.14?
> 
> /Bruno
> 
BR,
Yousaf
