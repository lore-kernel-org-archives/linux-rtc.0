Return-Path: <linux-rtc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32B8C6FD19
	for <linux-rtc@archiver.kernel.org>; Thu, 16 Mar 2023 15:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjCPPML (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 16 Mar 2023 11:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbjCPPMG (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 16 Mar 2023 11:12:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DB4C2D8C;
        Thu, 16 Mar 2023 08:11:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E72E9B82251;
        Thu, 16 Mar 2023 15:11:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CBDDC433EF;
        Thu, 16 Mar 2023 15:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678979509;
        bh=0SDwYMX634vKGtqAdMiwGc8QbGD5xDHPBVFQJhj/VZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LDic6cUT/JPp7QSGD9hYXpWnc4H69vtjkvl3y8dCxMiwjsgFUs0qjOtQktWLO0mIu
         IMtvPiCGr7WjHUcnoiactxObpGoaM3XVm/AZWbKcNyTrfsj6vOUmrU4mX7jg7q+G6a
         2Wpz42Mtz14DR0m/uwJg2MpdhwKPNluewJ4pG4CdKa55CjASM+judLAiSP3MvgfGB8
         XLHgy5CupuNtHe7Z6avs7qvwUGreUB9iqapuRrXac/26YDTR2q+PWech8vzzjQr9xS
         iANHbC4nuFUxhGcXslHvF5BZ3mzi4Kg0Wps/0DAcnSNilBvVtAoJmrOxBBqDGleMOt
         WkWRoWV53BMNw==
Date:   Thu, 16 Mar 2023 15:11:45 +0000
From:   Lee Jones <lee@kernel.org>
To:     David Virag <virag.david003@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH 1/2] mfd: sec: Remove PMICs without compatibles
Message-ID: <20230316151145.GF9667@google.com>
References: <20230131183008.4451-1-virag.david003@gmail.com>
 <20230131183008.4451-2-virag.david003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230131183008.4451-2-virag.david003@gmail.com>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Tue, 31 Jan 2023, David Virag wrote:

> The S5M8751 and S5M8763 PMIC chips have no corresponding compatible
> values, so since board file support was removed for this driver, there
> is no way to specify these PMICs as present in boards anymore.
> Remove leftovers of these chips since it's dead code.
>
> Signed-off-by: David Virag <virag.david003@gmail.com>
> ---
>  drivers/mfd/sec-core.c              | 46 ---------------
>  drivers/mfd/sec-irq.c               | 89 ----------------------------
>  include/linux/mfd/samsung/core.h    |  1 -
>  include/linux/mfd/samsung/s5m8763.h | 90 -----------------------------
>  4 files changed, 226 deletions(-)
>  delete mode 100644 include/linux/mfd/samsung/s5m8763.h

Applied, thanks

--
Lee Jones [李琼斯]
