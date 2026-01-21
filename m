Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69A5314A62;
	Wed, 21 Jan 2026 03:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768965794; cv=none; b=kVyv/54eU+BDGt6YCRDSYO0EPK6c5gSSTGXAZzr0Q2ssjdGqp0DzIyi5DC8xwkbidHi6eSUckZ+s/SIzcGouLbrck0Eujii/GIeg9E5dOc8aoXRynBO/rTwbyAaL+lchjUV5KsOm9hgN8JM2GvlwGLfZsm8x3c/uF3vDx1qFn2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768965794; c=relaxed/simple;
	bh=aSTSU23jMu/yYFT2TQbxkwOeXsQbKhvv8hpysfuJ4FU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBuXf4rOwvtJHYP+UsMOAvy/qg1JKryGO6N33fI0TaqokZ+buHR11CTUoA5TXmm/VUmAZZXzwyqcYbPMpfhqjBWR/DH47mMQdeR/UfnTLBkhHWws9rT8YQ7neDiP7/mMc0+zmjRvgPFqHVLQSynoBl0/+tgTxQgfZjTSwNB0sA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GIv8fT/Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GIv8fT/Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407E0C16AAE;
	Wed, 21 Jan 2026 03:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768965793;
	bh=aSTSU23jMu/yYFT2TQbxkwOeXsQbKhvv8hpysfuJ4FU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GIv8fT/Q6P1ifzY7L5P8i0S95t2snxZK/osly/FYhCpaUgeTQ2j7ElQydpFxC7n8w
	 TmYiRgwQvbdwy7helLQ2ATZMwbEPN5zF/VWA4d3wCnpSn0gjNu2Xlp3yDLgkNFyYNz
	 1ldrzAm2c+DOmx6Bo/DIqHREufs06V6VcknMuC7w=
Date: Tue, 20 Jan 2026 22:23:12 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Lee Jones <lee@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, =?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>, 
	tools@kernel.org, users@kernel.org, Peter Griffin <peter.griffin@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	Juan Yescas <jyescas@google.com>, Douglas Anderson <dianders@chromium.org>, 
	kernel-team@android.com, Kaustabh Chakraborty <kauschluss@disroot.org>, 
	linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Samsung mfd/rtc driver alarm IRQ simplification
Message-ID: <20260120-incredible-ladybug-of-psychology-605faf@lemur>
References: <20251120-s5m-alarm-v2-0-cc15f0e32161@linaro.org>
 <176892415694.2292562.7457528145774108517.b4-ty@kernel.org>
 <20260120155241.GG1354723@google.com>
 <e9bde783-42f3-4f28-9a5e-aa65f36db9ca@sirena.org.uk>
 <20260120172405.GI1354723@google.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260120172405.GI1354723@google.com>

On Tue, Jan 20, 2026 at 05:24:05PM +0000, Lee Jones wrote:
> > If you fetch a series but don't delete it from the database then (with
> > b4 ty -d) then b4 will remember it and if any commits in what gets
> > applied match it'll generate a mail for b4 ty -a.  Usually that's when
> > some commits didn't get changed.
> 
> The last attempt to apply this failed with conflicts.
> 
> I wonder why b4 stored that as a success?

It doesn't actually know -- it just stores the retrieved series and then
checks if it can find any of them in the tree in a commit with your
authorship. Sometimes it breaks.

My plan is to put in interactive mode where you can do a quick sanity check --
currently it's all of nothing with "b4 ty -a".

-K
