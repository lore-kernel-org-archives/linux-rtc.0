Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B2539901A;
	Wed, 21 Jan 2026 08:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768985058; cv=none; b=dA+pidgC9Xa4GPrssSf5YkvPAnUK4EkXDLUV4X3Y2btjVcobqiBCLpPa8ymxcSI6h1d8Wu/KchnY0+/D3v/NzohHzn1n1HhGvuVexWaHBFbcethRAROmVQpo2uRNI+MPiODiLSpPiuFcPcd4q6DyexvWKdiecD7R3w1MZOHOl3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768985058; c=relaxed/simple;
	bh=FwxtKF+nI8VIjhxE8elADwa8ZK8nEFCmSxUQHVLyKsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8KP9vvHUZwfUh8snDhUDRlFQm3HOyXkO8B5MMKT2yUcfieynKAPWR+bfsXyye5jgAg+l3T1jjHbM3/gIm8KBh99D/qG/MmL8vxb9ctbSgqq0dTUzxv7kTWdQza21SF6ziiwOAlZ4EzgTXZcGtFpmJoHZgmzBZydaaOT8dUmA4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T974NFdi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T974NFdi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB59C116D0;
	Wed, 21 Jan 2026 08:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768985057;
	bh=FwxtKF+nI8VIjhxE8elADwa8ZK8nEFCmSxUQHVLyKsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T974NFdilCRjMZQkLd5MEoLxmeu19y6RYlURy9xHNMxPq1P0MDETjDj1uAzTdVK09
	 HfrL536gtkNSTyS8SW6GaCfsDFL/JhBcUq2dqWdrxCCn8LiVUx0AcJt0v0kRMGmIXB
	 sScvy97ps64vNV/B/DhGMJWbiL0cd/nD8JJQRd7EwX9kdkAXoXl5APCXBITHgSYUy4
	 15NICCKHoHRTP1oyaGlcamRqTt0IN0i5LOTrdQNFYp/AvDJdGv5QhLziFWd2p36lXK
	 tefTKHrtxUfvDmgfD3hB+peSvybhKoCqXZ9US2gkLbd5/zIMHdMGRZ5R9PjA0l/L7k
	 Dz42PTdCAXJuQ==
Date: Wed, 21 Jan 2026 08:44:09 +0000
From: Lee Jones <lee@kernel.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	tools@kernel.org, users@kernel.org,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>,
	Juan Yescas <jyescas@google.com>,
	Douglas Anderson <dianders@chromium.org>, kernel-team@android.com,
	Kaustabh Chakraborty <kauschluss@disroot.org>,
	linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Samsung mfd/rtc driver alarm IRQ simplification
Message-ID: <20260121084409.GA2367337@google.com>
References: <20251120-s5m-alarm-v2-0-cc15f0e32161@linaro.org>
 <176892415694.2292562.7457528145774108517.b4-ty@kernel.org>
 <20260120155241.GG1354723@google.com>
 <e9bde783-42f3-4f28-9a5e-aa65f36db9ca@sirena.org.uk>
 <20260120172405.GI1354723@google.com>
 <20260120-incredible-ladybug-of-psychology-605faf@lemur>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260120-incredible-ladybug-of-psychology-605faf@lemur>

On Tue, 20 Jan 2026, Konstantin Ryabitsev wrote:

> On Tue, Jan 20, 2026 at 05:24:05PM +0000, Lee Jones wrote:
> > > If you fetch a series but don't delete it from the database then (with
> > > b4 ty -d) then b4 will remember it and if any commits in what gets
> > > applied match it'll generate a mail for b4 ty -a.  Usually that's when
> > > some commits didn't get changed.
> > 
> > The last attempt to apply this failed with conflicts.
> > 
> > I wonder why b4 stored that as a success?
> 
> It doesn't actually know -- it just stores the retrieved series and then
> checks if it can find any of them in the tree in a commit with your
> authorship. Sometimes it breaks.
> 
> My plan is to put in interactive mode where you can do a quick sanity check --
> currently it's all of nothing with "b4 ty -a".

Got it.  Thanks for the explanation.

-- 
Lee Jones [李琼斯]
