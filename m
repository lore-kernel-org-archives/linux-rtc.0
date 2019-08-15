Return-Path: <SRS0=0gbv=WL=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D22C3A589
	for <linux-rtc@archiver.kernel.org>; Thu, 15 Aug 2019 21:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AAFF2089E
	for <linux-rtc@archiver.kernel.org>; Thu, 15 Aug 2019 21:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565906391;
	bh=mEVjBqVTehrFxgdgqD2Yu12Sff3Abl8yi0X38S7mGKs=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=ljnx+TfV3NlZEbRwOhuOyy9mnx570yDSbypQzKDS5c5SbBDUFAKKsAx0MBZkXmW0N
	 ivDcBh1c0T8WeY8oopC3h2T0g184fzkqnUUf1WAz4fr/LsxuQQsftVFdn+prk2A+d0
	 Al/0Or8xtp2WBfs7/+lmvqUlDHqf00URR3zPrYwM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733210AbfHOV7s (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 15 Aug 2019 17:59:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730803AbfHOV7r (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 15 Aug 2019 17:59:47 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C06492083B;
        Thu, 15 Aug 2019 21:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565906386;
        bh=mEVjBqVTehrFxgdgqD2Yu12Sff3Abl8yi0X38S7mGKs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=vrNCBIlOvUZBhh6F0hNPaJ+1mWyUYRM0n5/huK1edKLL7Mmq62L2XCswp10WUPDex
         dc/jveN4l9Nuka7NVBJSRzRUEFjAClFhy628vVpID6N5audrCf7h0cxG0XTeoTqUT8
         Q/iF1LI1EWCiVl/kzpooqVJ8SjZjOsgoAMnLW3zs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190815160020.183334-4-sboyd@kernel.org>
References: <20190815160020.183334-1-sboyd@kernel.org> <20190815160020.183334-4-sboyd@kernel.org>
Subject: Re: [PATCH 3/4] rtc: sun6i: Don't reference clk_init_data after registration
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Thu, 15 Aug 2019 14:59:45 -0700
Message-Id: <20190815215946.C06492083B@mail.kernel.org>
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Quoting Stephen Boyd (2019-08-15 09:00:19)
> A future patch is going to change semantics of clk_register() so that
> clk_hw::init is guaranteed to be NULL after a clk is registered. Avoid
> referencing this member here so that we don't run into NULL pointer
> exceptions.
>=20
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>=20

Looks like this fixed the sunxi boot crashes in -next. I'll add a tag
for kernelci credit.

