Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74039C433FE
	for <linux-rtc@archiver.kernel.org>; Fri, 11 Dec 2020 00:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F8762310C
	for <linux-rtc@archiver.kernel.org>; Fri, 11 Dec 2020 00:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393528AbgLKAY4 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 10 Dec 2020 19:24:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59326 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394203AbgLKAYj (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 10 Dec 2020 19:24:39 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607646237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MxfQM41I/JHdGAPtOE62NQwgsz+Gd67FL7vEU7noGAA=;
        b=iltMriflmw6FTepVzYVvASUEAksTy7vG05SxeLUloFB0XzALVdnZr3jJl+AVxFKpCKwDrx
        qPCNy39LNXYnQ1gQs+uznySPwANnswB51Embe9SD+YD3acJmJZvZpI1b4CnDIwwvTD+EZ6
        i2YDR+CNaPROvpGFazuEFwIQBBmdK9zjfrRIklaILPvQ4mv5xgaDqqR6l/UxHrHzfzY7cy
        Y74ivoriPtOkUITpFbXOpnjF8re1FSVQV8LvE1RT1wTaIM5BYCAPbBPYwaIYajIpzjFM/b
        2EyFQ5BBT1NQTlouBsrRIjhAs2m0jr1/Et/l8azl7U3N3lzam6dlMrvHxITucg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607646237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MxfQM41I/JHdGAPtOE62NQwgsz+Gd67FL7vEU7noGAA=;
        b=QqiI+bsh1hGvP6fDMEc8TrQ+8uZnQJdkK9bX6mjWgWCxtjRnAYMIK640bGWVlOx7QIcBem
        XiL7HqfqrutrB4Cg==
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Prarit Bhargava <prarit@redhat.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch 4/8] rtc: core: Make the sync offset default more realistic
In-Reply-To: <20201210235908.GA1781038@piout.net>
References: <20201206214613.444124194@linutronix.de> <20201206220541.960333166@linutronix.de> <20201210235908.GA1781038@piout.net>
Date:   Fri, 11 Dec 2020 01:23:57 +0100
Message-ID: <87czzhi40y.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Alexandre,

On Fri, Dec 11 2020 at 00:59, Alexandre Belloni wrote:
> On 06/12/2020 22:46:17+0100, Thomas Gleixner wrote:
>>  	/* Drivers can revise this default after allocating the device. */
>> -	rtc->set_offset_nsec =  NSEC_PER_SEC / 2;
>> +	rtc->set_offset_nsec =  10 * NSEC_PER_MSEC;
>
> I did retest, on a slow 100kHz i2c bus, with a fairly inconvenient RTC,
> The maximum offset to set the RTC was 4845533ns so I'd say 10ms is too
> large. Should we make that 5ms ?

Sure. As I said I pulled the 10 out of thin air.

> Apart from that, on the series, you can add my
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

I'll amend the s/10/5/ throughout the series while queueing the whole
pile in the timers/core branch unless you want it to be handled
differently.

Thanks,

        tglx
