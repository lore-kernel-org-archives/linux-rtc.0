Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBEBC433F5
	for <linux-rtc@archiver.kernel.org>; Tue, 14 Sep 2021 08:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FBA0601FC
	for <linux-rtc@archiver.kernel.org>; Tue, 14 Sep 2021 08:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhINIHL (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 14 Sep 2021 04:07:11 -0400
Received: from mga06.intel.com ([134.134.136.31]:29633 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230086AbhINIEj (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 14 Sep 2021 04:04:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="282922082"
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="282922082"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 01:02:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="471884982"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by orsmga007.jf.intel.com with SMTP; 14 Sep 2021 01:02:55 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 14 Sep 2021 11:02:55 +0300
Date:   Tue, 14 Sep 2021 11:02:55 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Mateusz =?utf-8?Q?Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
Cc:     linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: Re: [PATCH 7/7] Revert "rtc: cmos: Replace spin_lock_irqsave with
 spin_lock in hard IRQ"
Message-ID: <YUBXL7hnd42GwBn9@intel.com>
References: <20210912124214.81853-1-mat.jonczyk@o2.pl>
 <20210912124214.81853-8-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210912124214.81853-8-mat.jonczyk@o2.pl>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Sun, Sep 12, 2021 at 02:42:14PM +0200, Mateusz Jończyk wrote:
> Revert
> commit 6950d046eb6e ("rtc: cmos: Replace spin_lock_irqsave with spin_lock in hard IRQ")
> and add a comment.
> 
> As described in a previous
> commit 66e4f4a9cc38 ("rtc: cmos: Use spin_lock_irqsave() in cmos_interrupt()")
> from February 2020:
> 
>         cmos_interrupt() isn't always called from hardirq context, so
>         we must use spin_lock_irqsave() & co.
> 
> Indeed, cmos_interrupt() is called from cmos_check_wkalrm(), which is
> called from cmos_resume() - apparently not in an interrupt context.
> 
> A later
> commit 6950d046eb6e ("rtc: cmos: Replace spin_lock_irqsave with spin_lock in hard IRQ")
> did not take account of this and changed spin_lock_irqsave() to spin_lock().
> This may cause a deadlock as quoted in the body of
> commit 66e4f4a9cc38 ("rtc: cmos: Use spin_lock_irqsave() in cmos_interrupt()")
> mentioned earlier.

This regression was supposed to be fixed by
https://lore.kernel.org/linux-rtc/20210305122140.28774-1-chris@chris-wilson.co.uk/

What happened to that one? I don't see it in Linus's tree...

-- 
Ville Syrjälä
Intel
