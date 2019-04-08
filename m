Return-Path: <SRS0=NKr3=SK=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED185C282CE
	for <linux-rtc@archiver.kernel.org>; Mon,  8 Apr 2019 09:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB0520883
	for <linux-rtc@archiver.kernel.org>; Mon,  8 Apr 2019 09:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rkrGhECw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfDHJM5 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:12:57 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41357 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfDHJM5 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 8 Apr 2019 05:12:57 -0400
Received: by mail-lj1-f196.google.com with SMTP id k8so10495944lja.8
        for <linux-rtc@vger.kernel.org>; Mon, 08 Apr 2019 02:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=us0veiu/JWuAAkfBTHSdN6UAxnqplvpdFgPUJM13Sh8=;
        b=rkrGhECwcgUoLPTrtaj96lexHtVkRBUBYF7DW9l9KfAxVa3598ND3Z77XLGDYm0oPj
         wLYfd9ROUl4t4oztkIXHhusGsVSOERmwKpn+A/N5twjSl6QqVOSPQwWPVeGjH04DjxiL
         9KHV1RsXWjm7KnqOzgI4QvmXWeWlGBUAminPDDRGVTl+ObKJIZtWzD6Xsg+wGK3vKjDx
         zDofMzTtpsMZOog7J0qhLl3UoDj0Q4c0X9ULzMq6omVOE7Q5Ev8BpxIgHtfHodVwTmU8
         Zt/iOMYYB+qCtDrFleqO1Obo8SUjeweN4G1GndUGuXpwuYwh230Kz7S64GGyXFCOH/qN
         Czjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=us0veiu/JWuAAkfBTHSdN6UAxnqplvpdFgPUJM13Sh8=;
        b=tjzTkHg+NpPrSqTuHL7rhSFSo0sUiIKl8hsetfV+JmlD6+reSXGaiTY7LINsztvF+Z
         aEjKxckSVkxpc77C3k3E8fxwekx3IsmThR1K60Pts92nlPS5hngBSa9rz1+3D037leAk
         JxbOCKEI0lY0ms0qBAs3MzfSV3fX/cwxGyJgmkeji20JQP7KvKU1FQJcK6PPAfub6ZOh
         2vAFa4/yoqIKd19QBLEk/Y0R37xfdb+4x/RoNWra8zx4c7V7vJ5zQAv0pGJal15uYkx0
         gdpmxolaxVVHphMrsI4BT9/+nHb/ZmOA4UmTjYoRlWhDyqEY54N4AG64waTI98KJQzBp
         /31Q==
X-Gm-Message-State: APjAAAV0/7CkoD+KT9/vsrUo1jQlgFAGsd4S/2nR7CS6j1qlGK9oM9uI
        dm1YOK7qsJN8wTww+YrIyZKIeP5Q64/xDYCvuhgeKw==
X-Google-Smtp-Source: APXvYqyx7hbE8vdMXL4NMwV2jDmnpzDsiPco9Yvs4nGssoY4yPWN5A3k7+T6eO6u29z9DeVXRex7/Gno3Th96vuRtHI=
X-Received: by 2002:a2e:4a1a:: with SMTP id x26mr14908186lja.49.1554714775105;
 Mon, 08 Apr 2019 02:12:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190407211027.14012-1-alexandre.belloni@bootlin.com> <20190407211027.14012-4-alexandre.belloni@bootlin.com>
In-Reply-To: <20190407211027.14012-4-alexandre.belloni@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 8 Apr 2019 11:12:43 +0200
Message-ID: <CACRpkdbWkpMBnqsXfu07Kb3_S3+RF+swwBnSr-LVnxop7Ht-RA@mail.gmail.com>
Subject: Re: [PATCH 4/4] rtc: coh901331: convert to SPDX identifier
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Sun, Apr 7, 2019 at 11:10 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> Use SPDX-License-Identifier instead of the custom license line.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
