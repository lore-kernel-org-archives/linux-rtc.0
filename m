Return-Path: <SRS0=N8XL=NH=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9B9C46475
	for <linux-rtc@archiver.kernel.org>; Sat, 27 Oct 2018 16:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA7920828
	for <linux-rtc@archiver.kernel.org>; Sat, 27 Oct 2018 16:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MvDJfxsf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA7920828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbeJ1BHl (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sat, 27 Oct 2018 21:07:41 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38274 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728643AbeJ1BHl (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 27 Oct 2018 21:07:41 -0400
Received: by mail-lf1-f65.google.com with SMTP id p86so897264lfg.5
        for <linux-rtc@vger.kernel.org>; Sat, 27 Oct 2018 09:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZpbjKgFDxSJMX8InFdI7wu0DHZYYJkESAFKl0FVK5Xk=;
        b=MvDJfxsfFADOF7UaNVqIBm4/rCcfGE4rGArUTWdAo5wdmq5VjgZS1O7K5SQeuoZPf9
         7+OVU+IVtpHjoBegS/Ir4bY+0SpqyHqVhj+F+hs2mdoB9PrNDnEHTywqzFmgAo+Gw9u0
         bcWUu4TKD+FN1Uw+brb5MwVW/1u5TzuOWo36I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZpbjKgFDxSJMX8InFdI7wu0DHZYYJkESAFKl0FVK5Xk=;
        b=FJat3WYgW0wRFil3IhZHNTT28RuvnIaYzNlQTqjHrv8dU7sH+PaYOvU/hAQ+DsjI+G
         ZiGGjmpi2EmOX1hAxJLvUeLaddOOJllNX97UmSUCSAyitz/Z943Qtam2P5gX7mDnQbRy
         5ksYeY5vARynwmIHBKUfv8Fon/VIYeModxMnSuMFaSvTgWXDjpz6awVQrVyra5gHby4w
         bkqhLS9l5YnIdjnRRg9CQIdx7VPr0JZU2lohpA6SKeoT0VU+yf9DCm+a5pjVbIRBSQ5Q
         xkNuQQj0RxWQF1XQu30VCWmh1wZsRVFBi2CRrLPMbfFPb/6c0zlZqn9ohZ6SdPUcWHTb
         IVSg==
X-Gm-Message-State: AGRZ1gKUckR77GKLO5XPXQGbuS70VpMy9jEX2A2fXS/bEjqAHA7ZWXHd
        p9QWXIfRibmTekW8Hu6ezkQ9GHy1lqqw+Q==
X-Google-Smtp-Source: AJdET5elErZ0Fh68xBf/LZRHjnZYQss09piTjSUseG/Fap0tahIO+cfxngCjw6xPhvWgjgIZRfMAqg==
X-Received: by 2002:a19:9dd1:: with SMTP id g200mr4153171lfe.127.1540657569086;
        Sat, 27 Oct 2018 09:26:09 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id b21-v6sm2242049lfi.17.2018.10.27.09.26.08
        for <linux-rtc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 09:26:08 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id f3-v6so3934172ljk.9
        for <linux-rtc@vger.kernel.org>; Sat, 27 Oct 2018 09:26:08 -0700 (PDT)
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr5046480ljh.59.1540657567675;
 Sat, 27 Oct 2018 09:26:07 -0700 (PDT)
MIME-Version: 1.0
References: <20181026205506.GA14231@piout.net>
In-Reply-To: <20181026205506.GA14231@piout.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 27 Oct 2018 09:25:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiZJwUyss4-nUnG1B4dUx1rP+pL9-qHnZ=HGFhvax2L9Q@mail.gmail.com>
Message-ID: <CAHk-=wiZJwUyss4-nUnG1B4dUx1rP+pL9-qHnZ=HGFhvax2L9Q@mail.gmail.com>
Subject: Re: [GIT PULL] RTC for 4.20
To:     alexandre.belloni@bootlin.com
Cc:     linux-rtc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Fri, Oct 26, 2018 at 1:55 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Here is the pull-request for the RTC subsystem for 4.20.
>
> This cycle, there were mostly non urgent fixes in drivers. I also
> finally unexported the non managed registration.

Pulled,

               Linus
