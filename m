Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD131286425;
	Sat, 25 Jul 2026 22:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785020160; cv=none; b=eiiSbRyN68cFCzNEASZV5vrolKgI3uKyhpkvkdlL59Zaq+7/7SxeOPVeSYOBi/sd7+QaOo5g3VTj5GEDhRaJkynrO9nLEWF9o/RAkw8cR6EVRd0WCvwCAGp/UAP4pS7vj22vjGlSjf07qRhygW0FJsbRls9jaTi7zvYPzGp8WwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785020160; c=relaxed/simple;
	bh=B9NCKoUoJU/1EAbzc0PbyaPxgauAvRu340M6DlCKfW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCjhPUF5x4I0ySjUqehN8REO7BiN2YWaDtEHpiCtI3vJ60A2ZwC4lxR86CicUE3Snufzg4jSL5wbjOAtV9aoAD6Dp6wc93a9C8ghhNkvvbBHKLh0Z4zy1Kxpjt4cBlE/ile/eQp7k6IvkcgeVot0WIQPNcMN5hQs2w3FYJvSotg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DA1E0E3f; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DA1E0E3f"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0596D4E40F60;
	Sat, 25 Jul 2026 22:55:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AEF7E6039A;
	Sat, 25 Jul 2026 22:55:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F368711C10784;
	Sun, 26 Jul 2026 00:55:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785020147; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=P9/nVjd3fMouCVIy5ky/jRRRBoNzhhxohToy1vtH9N0=;
	b=DA1E0E3fz5DjOzLSHget2aL34+lLHc0UySgVqkGrXY9dWBt9mGsMGfsaCCY7D4fVdYsN/B
	wnKkdV44g2GjBypPsauiweg1Cw28HU5NLgxE/S1+Axna1E4izSoNCGckXx1WkWLwBGshTB
	DBozggAdfya1EGiIgBBzfpvplXvuconGzZ/8Oqq2W+VrrZLJGkEpKg1mO+qGpdDAGdMlrY
	3xMa1pehoeeSaabU6ou7guTGpPFqh90UcQ0i8NTf/XWpsdpzvmyrx2WhWn1IWifPPG7E7R
	ySPGva/kk9TCO16L78sR1M3FnvHEBkVHiXh0bu1xhF3x8dc3Iyk2mDQOoG/0EA==
Date: Sun, 26 Jul 2026 00:55:45 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, conor+dt@kernel.org,
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	robh@kernel.org
Subject: Re: [PATCH v2 2/8] rtc: abx80x: move part autodetection before
 RV1805 configuration
Message-ID: <20260725225545942a7df7@mail.local>
References: <20260725145718.14733-1-apokusinski01@gmail.com>
 <20260725145718.14733-3-apokusinski01@gmail.com>
 <20260725150753.325271F000E9@smtp.kernel.org>
 <amUI6JY3BFTrbdqp@antoniarch>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amUI6JY3BFTrbdqp@antoniarch>
X-Last-TLS-Session-Version: TLSv1.3

On 25/07/2026 21:19:36+0200, Antoni Pokusinski wrote:
> On Sat, Jul 25, 2026 at 03:07:52PM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Medium] The patch fails to resolve the issue it describes because part autodetection for the RV1805 incorrectly resolves to AB1805.
> > --
> > 
> > --- Patch [2]: [PATCH v2 2/8] rtc: abx80x: move part autodetection before RV1805 configuration ---
> > commit e37ea6c1257442ff3423e6bacb742916beb85bbb
> > Author: Antoni Pokusinski <apokusinski01@gmail.com>
> > 
> > rtc: abx80x: move part autodetection before RV1805 configuration
> > 
> > This commit moves the part autodetection logic before the RV1805
> > configuration block. The intention is to ensure the RV1805 specifics are
> > applied even when the driver is bound using a generic compatible string.
> > 
> > > diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> > > index 5486d9d0b1e5d..ca3af91c29977 100644
> > > --- a/drivers/rtc/rtc-abx80x.c
> > > +++ b/drivers/rtc/rtc-abx80x.c
> > > @@ -814,6 +814,25 @@ static int abx80x_probe(struct i2c_client *client)
> > >  		return -EIO;
> > >  	}
> > >  
> > > +	/* part autodetection */
> > > +	if (part == ABX80X) {
> > > +		for (i = 0; abx80x_caps[i].pn; i++)
> > > +			if (partnumber == abx80x_caps[i].pn)
> > > +				break;
> > 
> > [Severity: Medium]
> > Does this code introduce a regression by preventing the RV1805 configuration
> > from running during autodetection?
> > 
> > Since AB1805 and RV1805 share the same part number (0x1805), and AB1805
> > appears earlier in the abx80x_caps array, it appears this loop will always
> > match AB1805 first.
> > 
> > If the driver is bound using the generic abracon,abx80x compatible string,
> > part will be set to AB1805 instead of RV1805.
> > 
> Ok so I missed the fact that "AB1805 and RV1805 share the same part number".
> Hence, I see no way to make the driver run the RV1805 configuration when
> it is bound using the generic ABX80X, because it may happen that the
> detected part is RV1805 even though the real one is AB1805 or the
> reverse (depending on the order that we define in `abx80x_caps[]`).
> Therefore, I'll drop this patch in v3 and leave things as they were
> (i.e. autodetecton after the `if (part == RV1805)` ).

Yes, don't bother. Autodetection was a bad idea anyway and will never be
used with an rv1805.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
