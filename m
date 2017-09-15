Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:36540 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751164AbdIOHNd (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 15 Sep 2017 03:13:33 -0400
Date: Fri, 15 Sep 2017 09:13:26 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] powerpc/5200: dts: digsy_mtc.dts: fix rv3029
 compatible
Message-ID: <20170915091326.4b93bde1@crub>
In-Reply-To: <20170915020004.24272-3-alexandre.belloni@free-electrons.com>
References: <20170915020004.24272-1-alexandre.belloni@free-electrons.com>
        <20170915020004.24272-3-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Fri, 15 Sep 2017 04:00:04 +0200
Alexandre Belloni alexandre.belloni@free-electrons.com wrote:

>The proper compatible for rv3029 is microcrystal,rv3029.
>
>Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Anatolij Gustschin <agust@denx.de>
