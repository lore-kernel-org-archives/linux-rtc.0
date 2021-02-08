Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E47C433DB
	for <linux-rtc@archiver.kernel.org>; Mon,  8 Feb 2021 03:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B11D564D9C
	for <linux-rtc@archiver.kernel.org>; Mon,  8 Feb 2021 03:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhBHDpU (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sun, 7 Feb 2021 22:45:20 -0500
Received: from vulcan.kevinlocke.name ([107.191.43.88]:46406 "EHLO
        vulcan.kevinlocke.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhBHDpU (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 7 Feb 2021 22:45:20 -0500
Received: from kevinlocke.name (host-69-145-60-23.bln-mt.client.bresnan.net [69.145.60.23])
        (Authenticated sender: kevin@kevinlocke.name)
        by vulcan.kevinlocke.name (Postfix) with ESMTPSA id 2BCA9203890E;
        Mon,  8 Feb 2021 03:44:39 +0000 (UTC)
Received: by kevinlocke.name (Postfix, from userid 1000)
        id BC05113054F1; Sun,  7 Feb 2021 20:44:37 -0700 (MST)
Date:   Sun, 7 Feb 2021 20:44:37 -0700
From:   Kevin Locke <kevin@kevinlocke.name>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-rtc@vger.kernel.org
Subject: Re: [v5.11-rc6 Regression] RTC_RD_TIME EINVAL after RTC_WKALM_SET
Message-ID: <YCCzpQj2pTDLdj8o@kevinlocke.name>
Mail-Followup-To: Kevin Locke <kevin@kevinlocke.name>,
        Thomas Gleixner <tglx@linutronix.de>, linux-rtc@vger.kernel.org
References: <YCBVEp77/1BFL9E0@kevinlocke.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCBVEp77/1BFL9E0@kevinlocke.name>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Sun, 2021-02-07 at 14:01 -0700, Kevin Locke wrote:
> On a ThinkPad T430 (2342-CTO) using rtc_cmos, on v5.11-rc6 (and torvalds
> master, 825b5991a46e), ioctl(RTC_RD_TIME) returns EINVAL after a wake
> alarm is set using ioctl(RTC_WKALM_SET), as observed using rtcwake(8):

I'm unable to reproduce the issue on v5.11-rc7.  Presumably it was fixed
by ebb22a059436, although I didn't bisect to confirm.  Sorry for the
noise.

Best,
Kevin
