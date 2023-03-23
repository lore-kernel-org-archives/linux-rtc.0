Return-Path: <linux-rtc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C018EC6FD1C
	for <linux-rtc@archiver.kernel.org>; Thu, 23 Mar 2023 09:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjCWJxW (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 23 Mar 2023 05:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjCWJws (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 23 Mar 2023 05:52:48 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FB51EFEB;
        Thu, 23 Mar 2023 02:51:22 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B26E81C0015;
        Thu, 23 Mar 2023 09:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679565081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0GdL9V8+kqcM/P7z/BTPRpF4LR7vDIdeFPwhLv86l9I=;
        b=AHXDvjU6VkuN6x8sZ6mnk5Vw618p4btlNhJHiaDcIJfwzdKSyAC0TqJpdY0nRDb/+FrF4c
        OwLAhEYmYOawJCp484w9Xy+LyDx+J28utvG6WO0XB6w/b77gCx5iG22z8/vU0nA57B/1WM
        XDlI67c8IWl2TDsu1DIM4U0h6qWctDz5xpItce/oES3PTqyFu2VZmRhmQmpivsGkZHjKcu
        7AwYYVL6ys/s51CBC6ZGXk6OpY7HjqDU01i7MAQAjBvnx29BVHOQrMBYtrwTVlTIwgZnRD
        YRu/te5gb3gDgrWLikkZsYNzDMJNpUQ+RTeDuFBHO1I8W2bIZNCG7sf1Sy1l2A==
Date:   Thu, 23 Mar 2023 10:51:20 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Dhruva Gole <d-gole@ti.com>
Cc:     Vibhore Vardhan <vibhore@ti.com>, linux-rtc@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V2] rtc: k3: handle errors while enabling wake irq
Message-ID: <167956506487.945041.7629865316588831836.b4-ty@bootlin.com>
References: <20230323085904.957999-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323085904.957999-1-d-gole@ti.com>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org


On Thu, 23 Mar 2023 14:29:04 +0530, Dhruva Gole wrote:
> Due to the potential failure of enable_irq_wake(), it would be better to
> return error if it fails.
> 
> 

Applied, thanks!

[1/1] rtc: k3: handle errors while enabling wake irq
      commit: d31d7300ebc0c43021ec48c0e6a3a427386f4617

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
