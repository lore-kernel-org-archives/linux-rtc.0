Return-Path: <SRS0=ZSCd=SL=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C38C10F0E
	for <linux-rtc@archiver.kernel.org>; Tue,  9 Apr 2019 10:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 236A6206B7
	for <linux-rtc@archiver.kernel.org>; Tue,  9 Apr 2019 10:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUI6/UVb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbfDIKqb (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:46:31 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:47083 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfDIKqa (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 9 Apr 2019 06:46:30 -0400
Received: by mail-ot1-f53.google.com with SMTP id s24so9908152otk.13
        for <linux-rtc@vger.kernel.org>; Tue, 09 Apr 2019 03:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6gpvpexjoYvvDEvxk/oabjjxxi/cAFVvO5tWfej+nZw=;
        b=JUI6/UVbfuCgMqLv7PM2XNYmxzWJjuC2JYZV/evpWWKj7rneige2tIYVWD6HN0NHBy
         ByXmMBJQNHqyReEBJrBPGsgbcCSceCl5OLKDqBMZ1kkxLLgh5ENPvGH3aLP6C2JD326W
         Q9IrcyVEXdY9SsEQpxCeAm1HN+jeO8NSptROi/pNwcTm/FgKJ6BS9nZlyMC3qiM22uHW
         qcMO33fEZLkm3UooA8KJ7cu2ifDqLgJ8Y1Ew/r0R3oClhEIWvOuVMnr1+dgo+Er2rk38
         Yoex/g7wgnuCXO1M0X5kWTuZbz680BzlNZc3138dUwo13K+RHuZUvLKQo6flliXQBifr
         beew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6gpvpexjoYvvDEvxk/oabjjxxi/cAFVvO5tWfej+nZw=;
        b=HrxFRgerMAY6Z3UNL8hJ9z/0IyW+Z95ljDO2tsqxobBRxqidWIwqNdWF8bnzYBO67F
         8w9Z5CbjOer+ZvTV63cxaE//ronHeP0fb8StRgJlDtC7aijiQ2jwhUT/N5KPMbS0Wsbf
         xfO06eyLR9ZQbdjV/yR2f2ETM1nQw2kxJIfMZAEOlxzbaB3if1Zgx74TPUXkUPjcvehR
         gr7Ttkque9kp+6AmHMXZKDoH5V/hf4P95cV/dFX9nq1fT2HQmRV00rmqWW9yZaNThS2l
         U64r/wy8kAAvRcx8V1UVLt+UCV4x7HcyAqVLCvvdBlmImrIy6R4b1pJG3KxJozc01OKm
         SZeQ==
X-Gm-Message-State: APjAAAV08jbPr0/Jba13VqVNfsaWcx7gWhR+sg8UnQT3RIkqybaSKT89
        3au66aoQikdGZO3TxExlkOzKXkvjB+nwRpSRSMBMzAtx
X-Google-Smtp-Source: APXvYqwWbE817GDXu5cvne3geoPV/o0ZhmtxOPGD9rRV3zrVBLFnt1G/bvouGF8cTd90Nm5CYutX4GgYF9sjlZtJEOI=
X-Received: by 2002:a05:6830:1092:: with SMTP id y18mr21436749oto.130.1554806789939;
 Tue, 09 Apr 2019 03:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <CADjOgT97-8PM1=Nm+Mk4jw_8vzt3i9KXUohDAkUsptxS7JuU6Q@mail.gmail.com>
 <20190409090119.GT7480@piout.net>
In-Reply-To: <20190409090119.GT7480@piout.net>
From:   Mastro Gippo <gipmad@gmail.com>
Date:   Tue, 9 Apr 2019 12:46:20 +0200
Message-ID: <CADjOgT-BK2SyoZD76iLj-fYG-7-2G0SvkFC4M6zakQc+7Q3g_w@mail.gmail.com>
Subject: Re: Infinite loop on edge cases
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     a.zummo@towertech.it, linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi Alexandre,
thank you for your comments.
Since failure behaviour is not specified in the Maxim datasheet, the
gracious way to handle this would be a retry counter, as that would
also solve the problem of a DS1307 that for some reason doesn't set
the CH bit (maybe an internal oscillator failure?). A similar erratic
behavior happened to me once, due to an unstable power supply to the
RTC.
IMHO, I think that a hardware failure and/or a problematic I2C driver
should not produce an infinite loop - be it fatal or not.
I already solved my boot issue with this patch, and I will ship it
with the devices I sell, but may I ask you what approach would you
recommend instead of hctosys? I tried looking online for solutions but
couldn't find an "official" one. I will gladly investigate better
approaches if available.

Thank you,
Best regards
Cristiano Griletti - Mastro Gippo
