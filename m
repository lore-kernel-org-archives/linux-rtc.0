Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:33566 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753127AbdHBMbn (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 2 Aug 2017 08:31:43 -0400
Received: by mail-it0-f44.google.com with SMTP id v127so24501073itd.0
        for <linux-rtc@vger.kernel.org>; Wed, 02 Aug 2017 05:31:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <E1dYKiF-0001kS-1w@rmk-PC.armlinux.org.uk>
References: <20170720231745.GE31807@n2100.armlinux.org.uk> <E1dYKiF-0001kS-1w@rmk-PC.armlinux.org.uk>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 2 Aug 2017 14:31:41 +0200
Message-ID: <CACRpkdarOfyYZnJeu5_tLsgfd+LTAOnDw5=gi59r-EG5M3Zmzw@mail.gmail.com>
Subject: Re: [PATCH 2/4] rtc: pl031: use devm_* for allocating memory and
 mapping resource
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>, linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Fri, Jul 21, 2017 at 1:18 AM, Russell King
<rmk+kernel@armlinux.org.uk> wrote:

> Use the devm_* APIs for allocating memory and mapping the memory in
> the probe function to relieve the driver from having to deal with
> this in the cleanup paths.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
