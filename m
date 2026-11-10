Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794288834;
	b=iyMpOSZnDiylF53HUBIZhINsR3viiT8z6CFV8OxR/sr7AlgFsbAqQ0yVxOK3h/aB7LgC
	 EtMCJPeWc2pWjsUHqjl9k+MHjHSULu7qW12GS8wxq+1kf9k+1n8yctFTIwyHAhGs7z3pe
	 Ex76K5JBtG7FpK+TUhj8lexuiFnhzoXBwTqPHxdz5Y5MT8E6S+9S7jJtD0wIYzs7jqfXq
	 gyXFFOV/yeT2Cs839ok2iRKqmNQyodiVIDbvv01SO/9Z78D56cVhbmOl4Hru+OWgzxs7u
	 M0fXe46rSgqjRYTu0xTY3L2LJXfip7kmDGvrg/G8lCnzJIEzfGiqD4+VnFVW5m2dV9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794288834;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0nrqEAsw91TWHA4QLzaVQ/nSNdp4UUFq+nfUAEE7UXk=;
	b=q3bxtLgTg70SnL0sMt4V/+RW48EC8T6a+PWTMXtEhhrbztwVeosX25LqeKfTznlxBN6o
	 9RLugsbhcsHaGTtLZkOy0TPSxKBazYPLFyG6IPeZottBHbL0ayOzaFGoyeJGYVAk7NCvN
	 6lLtSfrKNqimKTGSOjRsXjIBUK1bvuiN+5qz1/M7hGeMwPFwZ6J1SRP686GhLK89Cm2ut
	 vfTHYapRiHseTdYz2mjBMfs4bxsXwT/1LokgA1wMq8qnXmdlRlrjLGyQB4Ddq1tbGb0IO
	 qazimQiox/F6PbvqrddVqFz29wx/ztxWBpWOZt49owvt3F2tSQTtrwVX0HRMsl/FdJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=tUBD9Dz1;
	arc=none smtp.remote-ip=91.218.175.4
Received: from mta0.migadu.com (out-4.mta0.migadu.com [91.218.175.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008BC60A261F
	for <linux-rtc@vger.kernel.org>; Tue, 10 Nov 2026 05:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 008BC60A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=tUBD9Dz1
X-Envelope-To: linux-rtc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CZLdBRKJbLeIbAH9EL704bhwgZWuakCTKdVW4OGDyRg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794288831; v=1; x=1794893631;
 b=tUBD9Dz11Pp/EpgJIRLThq476Ii88FS+4jt8syHB4syOBqXJtHxpO6tIiVKKprO8v2lQSbpx
 TD0l9h7+22T8wSZhFLwgzptIufYsE/7d1FD9qR6dB0XxZJH32N3aBlVsOe/pLB9Oi+BY/BfnNUz
 MPR5XaZZUeSn7OpLkOrRrBfU=
X-Envelope-To: linux-rtc@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 612c80f98391c12d;
	Tue, 10 Nov 2026 05:33:51 +0000
X-Mizu-Trace-ID: 612c80f98391c12d
X-Migadu-Flow: FLOW_OUT
Date: Tue, 10 Nov 2026 05:33:40 +0000
From: Akhilesh Patil <akhilesh.patil@linux.dev>
To: Joshua Crofts <crofts@kernel.org>
Cc: jic23@kernel.org, dlechner@baylibre.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-rtc@vger.kernel.org, akhileshpatilvnit@gmail.com,
	akhilesh@ee.iitb.ac.in
Subject: Re: [PATCH v2] MAINTAINERS: Update Akhilesh Patil Email address
Message-ID: <20261110053340.GA2506228@u5ce4748bae3b54.ant.amazon.com>
References: <20261109063924.GA118887@u5ce4748bae3b54.ant.amazon.com>
 <20261109104443.GA531570@u5ce4748bae3b54.ant.amazon.com>
 <20261109130107.000056f8@kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109130107.000056f8@kernel.org>

On Mon, Nov 09, 2026 at 01:01:07PM +0100, Joshua Crofts wrote:
> On Mon, 9 Nov 2026 10:44:43 +0000
> Akhilesh Patil <akhilesh.patil@linux.dev> wrote:
> 
> > Move to my new linux.dev email address akhilesh.patil@linux.dev
> > I plan to use this email for kernel development going forward.
> > Also update email address in few yaml and driver source files.
> > 
> > Signed-off-by: Akhilesh Patil <akhilesh.patil@linux.dev>
> > ---
> 
> Next time please don't send a v2 as a reply to v1, it can break
> tooling like b4.

ACK. Updating v3.

Regards,
Akhilesh

