Return-Path: <SRS0=RZYg=T4=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8BAC072B1
	for <linux-rtc@archiver.kernel.org>; Tue, 28 May 2019 03:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA168208C3
	for <linux-rtc@archiver.kernel.org>; Tue, 28 May 2019 03:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfE1DsJ (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 27 May 2019 23:48:09 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33602 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfE1DsJ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 27 May 2019 23:48:09 -0400
Received: by mail-ed1-f66.google.com with SMTP id n17so29585700edb.0;
        Mon, 27 May 2019 20:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ykAmZNM3+M0rf6HLjev/b1JXrJdjuyj6wZaqtDFtAlI=;
        b=bEkzV1RUMSdZmwHyEBsyYMCxvPUsPAllHosugonLRXE2fnLhrw+edjhaEiU+Y2d1hf
         KrFCxM/EXGvofnspEdRpqy4+SZdFPI0rV7x6/MPLMWyGX0kjRQ+xAu08Rz+jntU/F8LL
         HZ0uh2TxjUGhHOeH2FIUjwWpEkqwN5SSVErDLIb7meWwTpkejrDHJCVXTvbYkGA6Kg5t
         DC4aNP04rf42JTsPk+qTRmtzvdZ0QCWyUHjsr4EQgxFneBgr5ZZ0FtOU0KHh4bOK0ZyO
         0RoEnrCrlwwNER8n9D4CmEJfHx933PWSjV89rq9bHORNnhzcryozsZ6+A47OoZ6OpEFs
         /epQ==
X-Gm-Message-State: APjAAAW7p2sGvTvGY0YZVZWLQ1IAEXm/F94tkZqy7wnoSsGQ4IXISWAV
        1Xd7LqlLU6poSqd0rNmPJy41ZeN7gQk=
X-Google-Smtp-Source: APXvYqwZX2+i0QwLdk88jJ0CQhF6Fp5mg93Usl/JQnLDrpkhDARo7nzVXcj52Y+t01KYLRSBKsYyFg==
X-Received: by 2002:a50:fa01:: with SMTP id b1mr118474532edq.199.1559015286970;
        Mon, 27 May 2019 20:48:06 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id f19sm2057378eje.53.2019.05.27.20.48.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 20:48:06 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id t5so1149286wmh.3;
        Mon, 27 May 2019 20:48:06 -0700 (PDT)
X-Received: by 2002:a1c:e906:: with SMTP id q6mr1327240wmc.47.1559015286157;
 Mon, 27 May 2019 20:48:06 -0700 (PDT)
MIME-Version: 1.0
References: <290402405a34506997fd2fab2c4c1486dbe6b7e5.1558958381.git-series.maxime.ripard@bootlin.com>
 <834199999676fdb119f3aa1966eb1b1d1391f347.1558958381.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <834199999676fdb119f3aa1966eb1b1d1391f347.1558958381.git-series.maxime.ripard@bootlin.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 28 May 2019 11:47:56 +0800
X-Gmail-Original-Message-ID: <CAGb2v66bYFdv6=VUeQNvugMqOzg2L0dkgFbje7OE9pQC+FN0Fg@mail.gmail.com>
Message-ID: <CAGb2v66bYFdv6=VUeQNvugMqOzg2L0dkgFbje7OE9pQC+FN0Fg@mail.gmail.com>
Subject: Re: [PATCH 10/10] ARM: dts: r40: Change the RTC compatible
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Mon, May 27, 2019 at 8:01 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Unlike what's being reported in the device tree so far, the RTC in the R40
> is quite different from the H3. Indeed it doesn't have the internal
> oscillator output, and it has only a single interrupt. Let's add a
> compatible for it.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

There's a lot of unnecessary line reordering. Otherwise,

Acked-by: Chen-Yu Tsai <wens@csie.org>
