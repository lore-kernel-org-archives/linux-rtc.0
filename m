Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A43283FE5
	for <linux-rtc@vger.kernel.org>; Wed, 19 Aug 2026 16:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787157089; cv=none; b=G8qYUramW4G1Bt6yvBmniEXgpNSJI+65ykJiAPl6Z8K5bjQDo4xq6aby1SdJ/et6DULOu/r2oDsxTFY1Og5+cliVutyiQO7rw5k57YkJ5hz3CZrmLyY/jQ95nTki/OBz2g514KRCkF7jmwzmkRdDIr2fVRp+EMU5a1POP6tRF7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787157089; c=relaxed/simple;
	bh=crF6MndnVNesACh737MWW45lqeZyKqSzPKzq1jQpAYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYiEsOpQA4JgKBW+orHxCF1B4jDrgwZpaOB886JsFZC9We/05/O17/Kh9BXrPpZF0cxZ1AK87mKv9O7QDrKO7qDI79JWlAui87JwdKvhJD+HVPRe2Sw8eNpGKx9qk55gbPBEn4LRl3qW1g+ZmxczZ9XfcjvQSd/CqXsA+45Agig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jPJC7XMV; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jPJC7XMV"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0E4401A173C;
	Wed, 19 Aug 2026 16:31:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D75715FF42;
	Wed, 19 Aug 2026 16:31:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 20BFC11C75911;
	Wed, 19 Aug 2026 18:31:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787157086; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=QTj2HddIc84wSIJFSl5Jp8aIekXOy3U1e8P4Gtj21oU=;
	b=jPJC7XMV1LvZjan4HUYnb7ywrFB1n/aIb5zCrTWc0hd+HsHwpXmHZWeI/5pmwrWe5gWnIB
	+m/nGSOLQXgHt8TUckfV2The9FB4hlrd+rcne5O3l6v6Oo8tPnEbx1Eg2rFZztmqMAJE4p
	0j5w+gdoellHAfkSQLVBO8pInAZmmOgnw1OCg6ay+ZpwgSh7D4C1HWA28xtMXJl8jtG5El
	IAUq5pBuTibgFQX8ULVIOzXWmrrMNpcXkXAi5Ye/uKaffWaVA0LgHqpBNfJBEPlQ0lI+n+
	1xbTaL6H8Xo4ypLFXzJcB87QmqcoHYpPfGVNRcJXV/RJJod1qgCLzV+EvRl3aw==
Date: Wed, 19 Aug 2026 18:31:25 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Jack Lee <skunkolee@gmail.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: ds1343: replace symbolic permissions with octal
Message-ID: <178715693831.130787.798773328821418435.b4-ty@b4>
References: <20260612223534.77412-1-skunkolee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612223534.77412-1-skunkolee@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Fri, 12 Jun 2026 16:35:34 -0600, Jack Lee wrote:
> Symbolic permissions S_IRUGO and S_IWUSR are deprecated in favor of
> octal permissions. Replace S_IRUGO|S_IWUSR with 0644 and S_IRUGO
> with 0444.

Applied, thanks!

[1/1] rtc: ds1343: replace symbolic permissions with octal
      https://git.kernel.org/abelloni/c/2943ec93ee6f

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
