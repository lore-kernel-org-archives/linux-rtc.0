Return-Path: <SRS0=tSN2=P5=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3C0C2F42E
	for <linux-rtc@archiver.kernel.org>; Mon, 21 Jan 2019 15:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D572085A
	for <linux-rtc@archiver.kernel.org>; Mon, 21 Jan 2019 15:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548085012;
	bh=9cyEbVO5d0ARsaoiIm48WG0y40ADcrfc6vsGyvP4QcY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=li8KYpcYN5rELN68XPTIgb/iTQ5r1IXHKYDhMcw/0rFmSuEbg11jp/7BngCkar/Iq
	 U7K9QWdvLI7jffazvasFw45CIcOdlaG4bylFDqLOjgAFfhQNasReyLzguh9ys9KGQh
	 otB9VOo3dU5M7sei6qL8HtlK6c8O5YRoNtQBoOFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbfAUPgw (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:36:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:36472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729813AbfAUPeN (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 21 Jan 2019 10:34:13 -0500
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAB532089F;
        Mon, 21 Jan 2019 15:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548084853;
        bh=9cyEbVO5d0ARsaoiIm48WG0y40ADcrfc6vsGyvP4QcY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uVF/6+lO7t9YcUkLJFF5vYTo4PfbSw5ZQzMIdGElO9sYwDbWtCRBZjPoU+9vCI1Bn
         GULiMYl+fjQ9B2xbTd49V+i+lsz3dKOGcxdP05S+alDEB7D4zYSeZtCHhoS+fAltjM
         Om400i/DUbOE98LlsrqMN3uuE1JVuL1dAhgWjmqM=
Received: by mail-lf1-f43.google.com with SMTP id a8so15807021lfk.5;
        Mon, 21 Jan 2019 07:34:12 -0800 (PST)
X-Gm-Message-State: AJcUukdKueGEtUjuZBDvrf7TMHLMUePtAK6a4c3WgM+6/OJ4wIxfhNgF
        /FKAZE5RH6Wes+xhfyC6GbxesCyNS1jDmPtk2Z4=
X-Google-Smtp-Source: ALg8bN5tdmm6XujrwmZCk8uB39gt2w5h01nQQfx/AjbE/YcYkWqawxTf2titGeobAhgDvODqZaA0dqGM2W2I06DZKZo=
X-Received: by 2002:a19:10a4:: with SMTP id 36mr18619607lfq.60.1548084850953;
 Mon, 21 Jan 2019 07:34:10 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190121110938eucas1p2e008ce6dabb0e5c62fdac19dc1491463@eucas1p2.samsung.com>
 <20190121110930.8290-1-m.szyprowski@samsung.com>
In-Reply-To: <20190121110930.8290-1-m.szyprowski@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 21 Jan 2019 16:33:59 +0100
X-Gmail-Original-Message-ID: <CAJKOXPc46a1geNMizYFLjE+TZMtmPVNG-1eki_FPVCxhgKoXkQ@mail.gmail.com>
Message-ID: <CAJKOXPc46a1geNMizYFLjE+TZMtmPVNG-1eki_FPVCxhgKoXkQ@mail.gmail.com>
Subject: Re: [PATCH v2] rtc: s3c: Rewrite clock handling
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-rtc@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Mon, 21 Jan 2019 at 12:09, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> s3c_rtc_enable/disable_clk() functions were designed to be called multiple
> times without reference counting, because they were initially only used in
> alarm setting/clearing functions, which can be called both when alarm is
> already set or not. Later however, calls to those functions have been added to
> other places in the driver - like time and /proc reading callbacks, what
> results in broken alarm if any of such events happens after the alarm has
> been set. Fix this by simplifying s3c_rtc_enable/disable_clk() functions
> to rely on proper reference counting in clock core and move alarm enable
> counter to s3c_rtc_setaie() function.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> v2:
> - simplified code as suggested by Krzysztof
> ---
>  drivers/rtc/rtc-s3c.c | 74 ++++++++++++++++++-------------------------
>  1 file changed, 31 insertions(+), 43 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
