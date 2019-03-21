Return-Path: <SRS0=JUId=RY=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BD4C43381
	for <linux-rtc@archiver.kernel.org>; Thu, 21 Mar 2019 09:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB3020850
	for <linux-rtc@archiver.kernel.org>; Thu, 21 Mar 2019 09:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbfCUJqc (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:46:32 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:45139 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbfCUJqc (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 21 Mar 2019 05:46:32 -0400
Received: by mail-vk1-f193.google.com with SMTP id v187so1206061vkf.12;
        Thu, 21 Mar 2019 02:46:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oPSUure6dQRj1K0EryTgicPFNn4AF9rZcGr5y/m+ZKI=;
        b=ntC1MrqftdRXkCtCUuZ1ixxjYH/O5/lqGUxDlz74/L2n3ID11mezAt73BDKA3JtnI1
         bU/E2c3SU8D34wYF4EpFEcnZ+unn/DMbqQzJ18B37fPv1nHOVCRG4tO5XbUWpxQs58HO
         2s91G8om+/x+Wc6UsHbfXJVRCZHOM+kgKnBPAwGmYxYZvi1Dig5DY5D/wqD+ifFD7Ug2
         7VWxdGaXTkc8CUNcsev6RQ0Qmgiv68eGfEmWnYXOg9UaoXcOpNA1MK/AxF9Ye3Gb3YLP
         2N6yfv/L/GLs7v6XO/3Aw2lJTs8SJsQwMo49Yu8GZXaNHSB+raf9YF416k1BGRUvpo0Q
         WhRg==
X-Gm-Message-State: APjAAAXf1WvmsIXJZGrRl8c3daGFy878NSuJdQRqOH6oSC7VTlMOps2G
        i+Ni3E+Bqdz4mUj2IkhIdSv7M7+Wx5aBBc9gzc3/siv5
X-Google-Smtp-Source: APXvYqyLO0zahjmojMWQPbaKPjUJdbrbMaYvnvYNLRc7FG8Ocmt/bpvtMFHE1LdAqhIgwy187LutfrJlkazHfKz49cs=
X-Received: by 2002:a1f:711:: with SMTP id 17mr1578358vkh.65.1553161590696;
 Thu, 21 Mar 2019 02:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190320113010.8955-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20190320113010.8955-1-alexandre.belloni@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Mar 2019 10:46:19 +0100
Message-ID: <CAMuHMdX8rabWxvQzMGmrckqdrtDA-J+HTuatO3BsgJwLjpxaFQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] rtc: sh: stop resetting time to epoch
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Brandt <chris.brandt@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi Alexandre,

On Wed, Mar 20, 2019 at 12:30 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> There is no point in resetting the time to epoch as this means that
> userspace will never get the valuable information that time is actually
> invalid.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Impact before/after (cold boot):

    -sh-rtc fcff1000.rtc: setting system clock to 1970-01-01T00:00:00 UTC (0)
    +sh-rtc fcff1000.rtc: hctosys: unable to read the hardware clock

After warm boot (Linux reboot command):

    sh-rtc fcff1000.rtc: setting system clock to 2019-03-21T08:47:54
UTC (1553158074)

After reset (reset switch):

    sh-rtc fcff1000.rtc: hctosys: unable to read the hardware clock

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
