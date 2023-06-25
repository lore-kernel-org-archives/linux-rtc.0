Return-Path: <linux-rtc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039C1EB64DC
	for <linux-rtc@archiver.kernel.org>; Sun, 25 Jun 2023 23:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjFYXLV (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sun, 25 Jun 2023 19:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjFYXLU (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 25 Jun 2023 19:11:20 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AC2E42
        for <linux-rtc@vger.kernel.org>; Sun, 25 Jun 2023 16:11:18 -0700 (PDT)
X-GND-Sasl: alexandre.belloni@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687734677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0IDsnypy0byQrTHXDsPlFvZVKuAPCsf+7xh6aDDBpiE=;
        b=cV4QODjXEIMxPS2vpoaROhNmlMaAunfRKiCIRW834a19XQn/7YorIlxuq+iAO5dnWYJpq2
        Qcvz8E6l9c0LJ+/EeKkS5BOPCQJaccZ9zygHm7hc6SrFIgD5fJuW/wc7Pe7d+sT3kazCR1
        Yo7cMdd3A/qW9zKtS97h42yK766G46cupqoydkh2tIgg3uA1JyDNBV6JpJ9y50nrk62ztg
        ApChHyBb3z8lkW7BUfP8vATGYy7wQnrsCKtO61gbiR7MAn5OdHEaRyFXYFZp7ds7wZFkL/
        aXDiGZXx/EJsMu8GEMEtrAKLd1uDm80fZ3r7z+lPNSXW6dIPkZPmkcNO+sTskQ==
X-GND-Sasl: alexandre.belloni@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DF4C2E0007;
        Sun, 25 Jun 2023 23:11:16 +0000 (UTC)
Date:   Mon, 26 Jun 2023 01:11:16 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
Cc:     linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: rv3028: make rv3028 probeable from userspace
Message-ID: <202306252311169e4016a1@mail.local>
References: <20230327085550.1721861-1-johannes.kirchmair@sigmatek.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327085550.1721861-1-johannes.kirchmair@sigmatek.at>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 27/03/2023 10:55:50+0200, Johannes Kirchmair wrote:
> With this commit, it will be possible to bind a rv3028 device from
> userspace
> 
> This is done by:
> echo rtc-rv3028 0x52 > /sys/bus/i2c/devices/i2c-XX/new_device
> 
> Signed-off-by: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
> ---
>  drivers/rtc/rtc-rv3028.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

I applied it after fixing a merge issue and removing the rtc- prefix
from the i2c_device_id.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
