Return-Path: <linux-rtc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49FDC6FD1F
	for <linux-rtc@archiver.kernel.org>; Thu, 16 Mar 2023 15:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjCPPNk (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 16 Mar 2023 11:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjCPPNj (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 16 Mar 2023 11:13:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098D92E808;
        Thu, 16 Mar 2023 08:13:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BBA8B82252;
        Thu, 16 Mar 2023 15:13:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771D3C4339B;
        Thu, 16 Mar 2023 15:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678979598;
        bh=rqZMffWFujs1hJXDUL+lclulqKOD8zGLO5s7fzL9yjQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UfV0xsODZ7SkOKG6niZ3in/PLDlyunrWDvNPn9fk7yRQ7OlrTtX21pV048zSFQm/G
         +vT7L0tmR0/x4nGe3vylSyORyWAMV0Ha//0o/SGbT43Q13iyQoGMW2LsapGK/UD7an
         t1gpuPtRWH7SnKtJZ9dIzAG+92GVF/wwED3aMsV1uJT2K0Lk5/Cf0drH21rlYy2QXb
         lT3voOMMi0aLtTBac5YFcLy3+tZnuYVicSaIdZxfv5F6ix6UEvXKx9Bke+ecBBV1R+
         63DRi22ztEIs9ZTRKx0ww+m29KLYaaeBcs7z/YsR/bEkhVQ07HOXwEwh/P0pd9BFi+
         jnksjfMIgP6Pg==
Date:   Thu, 16 Mar 2023 15:13:13 +0000
From:   Lee Jones <lee@kernel.org>
To:     David Virag <virag.david003@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH 0/2] Remove SEC S5M MFDs with no compatibles
Message-ID: <20230316151313.GH9667@google.com>
References: <20230131183008.4451-1-virag.david003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230131183008.4451-1-virag.david003@gmail.com>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Tue, 31 Jan 2023, David Virag wrote:

> The S5M8751 and S5M8763 MFD PMICs have no compatibles, and board file
> support for them was removed, resulting in essentially no way for these
> chips to be used anymore (unless they get dt compatibles).
> They seemingly have never been in any board files upstream and I only
> found references to the SM8751 being on the SMDK6450 board (which has
> been unsupported for many years now) in a downstream Samsung Galaxy S2
> kernel tree.
>
> The patches should be applied in order.
>
> David Virag (2):
>   mfd: sec: Remove PMICs without compatibles
>   rtc: s5m: Drop S5M8763 support
>
>  drivers/mfd/sec-core.c              | 46 ---------------
>  drivers/mfd/sec-irq.c               | 89 ----------------------------
>  drivers/rtc/rtc-s5m.c               | 82 +-------------------------
>  include/linux/mfd/samsung/core.h    |  2 -
>  include/linux/mfd/samsung/irq.h     | 50 ----------------
>  include/linux/mfd/samsung/s5m8763.h | 90 -----------------------------
>  6 files changed, 3 insertions(+), 356 deletions(-)
>  delete mode 100644 include/linux/mfd/samsung/s5m8763.h

Pull-request to follow, once it passes build testing.

--
Lee Jones [李琼斯]
