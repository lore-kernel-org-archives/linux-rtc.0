Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:50596 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932977AbeBVPsE (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 22 Feb 2018 10:48:04 -0500
Date: Thu, 22 Feb 2018 07:48:03 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 000/100] rtc: remove cargo culted code
Message-ID: <20180222154802.GA2114@infradead.org>
References: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Wed, Feb 21, 2018 at 09:54:55PM +0100, Alexandre Belloni wrote:
> Hello,
> 
> This series:
>  - removes useless calls to rtc_valid_tm in .read_time, .set_time and
>    .set_alarm
>  - removes code setting default values for RTCs (and lets the core
>    handle it)
>  - removes useless "time is invalid" messages at probe time
>  - removes useless indirect calls

Seems like this could be just one patch for each of the issues..
